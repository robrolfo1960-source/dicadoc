import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/enums.dart';
import '../../core/theme.dart';
import '../../data/config/app_config.dart';
import '../anamnesi/anamnesi_providers.dart';
import '../anamnesi/anamnesi_repository.dart';
import '../anamnesi/anamnesi_screen.dart';
import '../monitora/monitora_providers.dart';
import '../terapia/terapia_providers.dart';
import 'profilo_providers.dart';

class ProfiloScreen extends ConsumerStatefulWidget {
  const ProfiloScreen({super.key});

  @override
  ConsumerState<ProfiloScreen> createState() => _ProfiloScreenState();
}

class _ProfiloScreenState extends ConsumerState<ProfiloScreen> {
  bool _syncHealth = false;
  String? _healthMsg;
  bool _scanQr = false;

  Future<void> _importaHealth() async {
    setState(() {
      _syncHealth = true;
      _healthMsg = null;
    });
    try {
      final svc = ref.read(healthServiceProvider);
      final disponibile = await svc.isDisponibile();
      if (!disponibile) {
        setState(() =>
            _healthMsg = 'Health Connect non disponibile su questo dispositivo.');
        return;
      }
      final pazienteId = ref.read(pazienteCorrenteIdProvider);
      final n = await svc.importa(pazienteId: pazienteId);
      ref.invalidate(parametriAbilitatiProvider);
      setState(() => _healthMsg = n > 0
          ? 'Importate $n misurazioni da Health Connect.'
          : 'Nessuna nuova misurazione trovata.');
    } catch (e) {
      setState(() => _healthMsg = 'Errore: $e');
    } finally {
      setState(() => _syncHealth = false);
    }
  }

  Future<void> _applicaQr(String raw) async {
    setState(() => _scanQr = false);
    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final pid = data['pid'] as int?;
      if (pid == null) throw const FormatException('Campo "pid" mancante');
      await AppConfig.instance.setPaziente(
        id: pid,
        nome: data['nome'] as String?,
        serverUrl: data['server'] as String?,
      );
      ref.invalidate(profiloDataProvider);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Paziente aggiornato')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('QR non valido: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_scanQr) return _buildQrScanner();

    final profiloAsync = ref.watch(profiloDataProvider);
    final anamnesiAsync = ref.watch(anamnesiProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profilo')),
      body: profiloAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Errore: $e')),
        data: (profilo) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- PAZIENTE ---
            _SectionHeader('Paziente'),
            if (profilo != null) ...[
              _InfoCard(Icons.person_outline, 'Nome',
                  '${profilo.paziente.nome} ${profilo.paziente.cognome}'),
              _InfoCard(Icons.cake_outlined, 'Data di nascita',
                  DateFormat('d MMMM yyyy', 'it_IT').format(profilo.paziente.dataNascita)),
              _InfoCard(Icons.badge_outlined, 'Codice Fiscale',
                  profilo.paziente.codiceFiscale),
            ],
            const SizedBox(height: 16),

            // --- PATOLOGIE ---
            _SectionHeader('Patologie'),
            if (profilo != null && profilo.patologie.isNotEmpty)
              ...profilo.patologie.map(
                (p) => Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.local_hospital_outlined,
                        color: AppTheme.brand),
                    title: Text(p.nome),
                  ),
                ),
              )
            else
              _EmptyHint('Nessuna patologia registrata'),
            const SizedBox(height: 16),

            // --- TERAPIE ATTIVE ---
            _SectionHeader('Terapie attive'),
            if (profilo != null && profilo.terapieAttive.isNotEmpty)
              ...profilo.terapieAttive.map(
                (t) => Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    dense: true,
                    leading:
                        const Icon(Icons.medication_outlined, color: AppTheme.brand),
                    title: Text(t.nomeFarmaco),
                    subtitle: Text(
                        '${t.dosaggio ?? ''} · ${t.priorita.etichetta}'),
                  ),
                ),
              )
            else
              _EmptyHint('Nessuna terapia attiva'),
            const SizedBox(height: 16),

            // --- ANAMNESI ---
            _SectionHeader('Anamnesi'),
            anamnesiAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (risposte) {
                final compilate = risposte.keys
                    .where((k) => domandheAnamnesi.contains(k))
                    .length;
                return Card(
                  child: ListTile(
                    leading: Icon(
                      compilate == domandheAnamnesi.length
                          ? Icons.assignment_turned_in_outlined
                          : Icons.assignment_outlined,
                      color: compilate == domandheAnamnesi.length
                          ? AppTheme.statoOk
                          : AppTheme.statoAttenzione,
                    ),
                    title: Text(compilate > 0
                        ? '$compilate / ${domandheAnamnesi.length} domande compilate'
                        : 'Questionario non compilato'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AnamnesiScreen()),
                    ).then((_) => ref.invalidate(anamnesiProvider)),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // --- HEALTH CONNECT ---
            _SectionHeader('Health Connect'),
            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite_border, color: AppTheme.brand),
                title: const Text('Importa da Health Connect'),
                subtitle: Text(_healthMsg ?? 'Pressione, glicemia, peso'),
                trailing: _syncHealth
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.sync),
                onTap: _syncHealth ? null : _importaHealth,
              ),
            ),
            const SizedBox(height: 16),

            // --- SICUREZZA ---
            _SectionHeader('Sicurezza'),
            const _InfoCard(Icons.lock_outline, 'Database',
                'Cifrato con SQLCipher (AES-256)', valueColor: AppTheme.statoOk),
            const _InfoCard(Icons.vpn_key_outlined, 'Passphrase',
                'Custodita nel keystore del dispositivo'),
            const SizedBox(height: 16),

            // --- SINCRONIZZAZIONE ---
            _SectionHeader('Sincronizzazione'),
            FutureBuilder<String?>(
              future: AppConfig.instance.getServerUrl(),
              builder: (_, snap) {
                final url = snap.data;
                return Column(
                  children: [
                    _InfoCard(
                      url != null
                          ? Icons.cloud_done_outlined
                          : Icons.cloud_off_outlined,
                      'Modalità',
                      url != null ? 'Cloud attivo' : 'Solo locale (offline)',
                      valueColor: url != null ? AppTheme.statoOk : null,
                    ),
                    if (url != null) _InfoCard(Icons.link, 'Server', url),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => setState(() => _scanQr = true),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scansiona nuovo QR del medico'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQrScanner() {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final raw = capture.barcodes.firstOrNull?.rawValue;
              if (raw != null) _applicaQr(raw);
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => setState(() => _scanQr = false),
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
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: Colors.black54, letterSpacing: 1.2),
        ),
      );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard(this.icon, this.label, this.value, {this.valueColor});
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 6),
        child: ListTile(
          leading: Icon(icon, color: AppTheme.brand),
          title: Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black54)),
          subtitle: Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: valueColor)),
        ),
      );
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.black45)),
      );
}
