import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/theme.dart';
import '../../data/config/app_config.dart';
import '../../data/sync/cloud_sync.dart';
import '../terapia/terapia_providers.dart';


/// Schermata di primo avvio (F4 ONBOARDING QR).
///
/// Offre due percorsi:
///  - Scansiona QR: il medico genera un QR che contiene pazienteId e
///    opzionalmente l'URL del server di sync.
///  - Usa dati demo: imposta pazienteId = 1 (dati seed).
///
/// Formato QR atteso: JSON  {"pid": 1, "nome": "Mario Rossi", "server": "https://..."}
/// Il campo "server" è opzionale (modalità offline se assente).
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool _scansione = false;
  bool _elaborando = false;
  String? _errore;

  Future<void> _applicaQr(String raw) async {
    if (_elaborando) return;
    setState(() {
      _elaborando = true;
      _errore = null;
    });
    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final pid = data['pid'] as int?;
      if (pid == null) throw const FormatException('Campo "pid" mancante');
      await AppConfig.instance.setPaziente(
        id: pid,
        nome: data['nome'] as String?,
        serverUrl: data['server'] as String?,
      );
      if (mounted) await _navigaApp(pid);
    } catch (e) {
      setState(() {
        _errore = 'QR non valido: $e';
        _elaborando = false;
        _scansione = false;
      });
    }
  }

  Future<void> _usaDemo() async {
    setState(() {
      _elaborando = true;
      _errore = null;
    });
    try {
      await AppConfig.instance.setPaziente(id: 1, nome: 'Mario Rossi (demo)');
      if (mounted) _navigaApp(1);
    } catch (e) {
      setState(() {
        _errore = 'Errore: $e';
        _elaborando = false;
      });
    }
  }

  Future<void> _navigaApp(int pid) async {
    // Aggiorna il provider a runtime — tutti i widget si ricostruiscono.
    ref.read(pazienteCorrenteIdProvider.notifier).set(pid);

    // Pull immediato dal server se configurato.
    final serverUrl = await AppConfig.instance.getServerUrl();
    if (serverUrl != null && serverUrl.isNotEmpty) {
      try {
        final db = ref.read(appDatabaseProvider);
        await CloudSync(db, serverUrl, pazienteId: pid).pull();
      } catch (_) {}
    }

    ref.invalidate(farmaciOggiProvider);
    if (mounted) Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.brand,
      body: SafeArea(
        child: _scansione ? _buildScanner() : _buildBenvenuto(),
      ),
    );
  }

  Widget _buildBenvenuto() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.health_and_safety_outlined,
              size: 80, color: Colors.white),
          const SizedBox(height: 24),
          Text(
            'DicaDoc',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aderenza terapeutica e monitoraggio remoto',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 48),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.brand,
            ),
            onPressed: () => setState(() {
              _scansione = true;
              _errore = null;
            }),
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Scansiona QR del medico'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white54),
            ),
            onPressed: _usaDemo,
            icon: const Icon(Icons.science_outlined),
            label: const Text('Usa dati demo'),
          ),
          if (_errore != null) ...[
            const SizedBox(height: 16),
            Text(
              _errore!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScanner() {
    return Stack(
      children: [
        MobileScanner(
          onDetect: (capture) {
            final barcode = capture.barcodes.firstOrNull;
            if (barcode?.rawValue != null) {
              _applicaQr(barcode!.rawValue!);
            }
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => setState(() => _scansione = false),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Text(
              'Punta la fotocamera sul QR del medico',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
        if (_elaborando)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
