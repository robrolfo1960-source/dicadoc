import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/db/database.dart';

class QrPazienteDialog extends StatefulWidget {
  const QrPazienteDialog({super.key, required this.paziente, this.serverUrl});

  final Paziente paziente;
  final String? serverUrl;

  static Future<void> mostra(
    BuildContext context, {
    required Paziente paziente,
    String? serverUrl,
  }) {
    return showDialog(
      context: context,
      builder: (_) => QrPazienteDialog(paziente: paziente, serverUrl: serverUrl),
    );
  }

  @override
  State<QrPazienteDialog> createState() => _QrPazienteDialogState();
}

class _QrPazienteDialogState extends State<QrPazienteDialog> {
  late final TextEditingController _urlCtrl;

  @override
  void initState() {
    super.initState();
    // Default: usa serverUrl configurato o localhost; IP rilevato in background.
    _urlCtrl = TextEditingController(
      text: (widget.serverUrl != null && widget.serverUrl!.isNotEmpty)
          ? widget.serverUrl!
          : 'http://localhost:8090',
    );
    _rilevaDns();
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  Future<void> _rilevaDns() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLinkLocal: false,
      ).timeout(const Duration(seconds: 2));
      for (final i in interfaces) {
        for (final addr in i.addresses) {
          if (!addr.isLoopback && mounted) {
            setState(() => _urlCtrl.text = 'http://${addr.address}:8090');
            return;
          }
        }
      }
    } catch (_) {
      // timeout o errore sandbox: resta su localhost
    }
  }

  String get _qrData => jsonEncode({
        'pid': widget.paziente.id,
        'nome': '${widget.paziente.nome} ${widget.paziente.cognome}',
        'server': _urlCtrl.text.trim(),
      });

  @override
  Widget build(BuildContext context) {
    final p = widget.paziente;
    return AlertDialog(
      title: Text('QR Onboarding — ${p.nome} ${p.cognome}'),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // QR aggiornato live quando cambia il testo
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _urlCtrl,
              builder: (_, value, __) {
                final data = jsonEncode({
                  'pid': widget.paziente.id,
                  'nome': '${p.nome} ${p.cognome}',
                  'server': value.text.trim(),
                });
                return QrImageView(data: data, size: 220);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _urlCtrl,
              decoration: const InputDecoration(
                labelText: 'Server URL',
                helperText: 'iPhone e Mac devono essere sulla stessa WiFi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              'Il paziente scansiona questo QR con l\'app DicaDoc\nper ricevere le terapie prescritte.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Chiudi'),
        ),
      ],
    );
  }
}
