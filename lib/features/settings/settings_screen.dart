import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/theme.dart';
import '../../data/config/app_config.dart';
import '../../data/sync/cloud_sync.dart';
import '../monitora/monitora_providers.dart';
import '../terapia/terapia_providers.dart';

final _settingsInfoProvider = FutureProvider<_Info>((ref) async {
  final config = AppConfig.instance;
  return _Info(
    pazienteNome: await config.getPazienteNome() ?? '—',
    pazienteId: await config.getPazienteId() ?? 1,
    serverUrl: await config.getServerUrl(),
    syncAbilitato: ref.watch(syncServiceProvider).isCloudEnabled,
  );
});

class _Info {
  const _Info({
    required this.pazienteNome,
    required this.pazienteId,
    required this.serverUrl,
    required this.syncAbilitato,
  });
  final String pazienteNome;
  final int pazienteId;
  final String? serverUrl;
  final bool syncAbilitato;
}

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _scansione = false;
  bool _resetting = false;

  Future<void> _riregistra() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Disassocia dispositivo'),
        content: const Text(
            'Verranno rimossi tutti i dati di configurazione.\n'
            'Al riavvio potrai scansionare un nuovo QR del medico.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Annulla')),
          FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Disassocia')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    setState(() => _resetting = true);
    await AppConfig.instance.reset();
    ref.read(pazienteCorrenteIdProvider.notifier).set(1);
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/onboarding', (_) => false);
    }
  }

  Future<void> _modificaServerUrl(String attuale) async {
    final ctrl = TextEditingController(text: attuale);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('URL server sync'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            labelText: 'es. http://192.168.1.95:8090',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.url,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Annulla')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Salva')),
        ],
      ),
    );
    if (ok == true && ctrl.text.trim().isNotEmpty) {
      await AppConfig.instance.setServerUrl(ctrl.text.trim());
      ref.invalidate(_settingsInfoProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Server aggiornato — riavvia l\'app')));
      }
    }
    ctrl.dispose();
  }

  Future<void> _applicaQr(String raw) async {
    setState(() => _scansione = false);
    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final pid = data['pid'] as int?;
      if (pid == null) throw const FormatException('Campo "pid" mancante');
      final serverUrl = data['server'] as String?;
      await AppConfig.instance.setPaziente(
        id: pid,
        nome: data['nome'] as String?,
        serverUrl: serverUrl,
      );
      ref.read(pazienteCorrenteIdProvider.notifier).set(pid);
      if (serverUrl != null && serverUrl.isNotEmpty) {
        try {
          final db = ref.read(appDatabaseProvider);
          await CloudSync(db, serverUrl, pazienteId: pid).pull();
        } catch (_) {}
      }
      ref.invalidate(_settingsInfoProvider);
      ref.invalidate(farmaciOggiProvider);
      ref.invalidate(parametriAbilitatiProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrazione completata — terapie sincronizzate')),
        );
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
    if (_scansione) return _buildScanner();

    final infoAsync = ref.watch(_settingsInfoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Impostazioni')),
      body: infoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Errore: $e')),
        data: (info) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SectionHeader('Paziente'),
            _InfoTile(Icons.person_outline, 'Nome', info.pazienteNome),
            _InfoTile(Icons.tag, 'ID paziente', '#${info.pazienteId}'),
            const SizedBox(height: 16),
            _SectionHeader('Sincronizzazione'),
            _InfoTile(
              info.syncAbilitato
                  ? Icons.cloud_done_outlined
                  : Icons.cloud_off_outlined,
              'Modalità',
              info.syncAbilitato ? 'Cloud attivo' : 'Solo locale (offline)',
              valueColor: info.syncAbilitato ? AppTheme.statoOk : null,
            ),
            if (info.serverUrl != null)
              _InfoTile(Icons.link, 'Server', info.serverUrl!),
            const SizedBox(height: 16),
            _SectionHeader('Sicurezza'),
            const _InfoTile(
              Icons.lock_outline,
              'Database',
              'Cifrato con SQLCipher (AES-256)',
              valueColor: AppTheme.statoOk,
            ),
            const _InfoTile(
              Icons.vpn_key_outlined,
              'Passphrase',
              'Custodita nel keystore del dispositivo',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => setState(() => _scansione = true),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scansiona nuovo QR del medico'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _modificaServerUrl(info.serverUrl ?? ''),
              icon: const Icon(Icons.link),
              label: const Text('Modifica URL server'),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              onPressed: _resetting ? null : _riregistra,
              icon: const Icon(Icons.logout),
              label: const Text('Disassocia — Ri-registra con nuovo QR'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanner() {
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
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.black54,
                letterSpacing: 1.2,
              ),
        ),
      );
}

class _InfoTile extends StatelessWidget {
  const _InfoTile(this.icon, this.label, this.value, {this.valueColor});
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: Icon(icon, color: AppTheme.brand),
          title: Text(label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                  )),
          subtitle: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      );
}
