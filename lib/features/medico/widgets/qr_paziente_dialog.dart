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
  String? _localIp;

  @override
  void initState() {
    super.initState();
    _rilevaDns();
  }

  Future<void> _rilevaDns() async {
    try {
      final interfaces = await NetworkInterface.list(
          type: InternetAddressType.IPv4, includeLinkLocal: false);
      for (final i in interfaces) {
        for (final addr in i.addresses) {
          if (!addr.isLoopback) {
            setState(() => _localIp = addr.address);
            return;
          }
        }
      }
    } catch (_) {}
  }

  String get _serverUrl {
    if (widget.serverUrl != null && widget.serverUrl!.isNotEmpty) {
      return widget.serverUrl!;
    }
    if (_localIp != null) return 'http://$_localIp:8090';
    return 'http://localhost:8090';
  }

  String get _qrData => jsonEncode({
        'pid': widget.paziente.id,
        'nome': '${widget.paziente.nome} ${widget.paziente.cognome}',
        'server': _serverUrl,
      });

  @override
  Widget build(BuildContext context) {
    final p = widget.paziente;
    return AlertDialog(
      title: Text('QR Onboarding — ${p.nome} ${p.cognome}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(data: _qrData, size: 240),
          const SizedBox(height: 12),
          Text(
            'Il paziente scansiona questo QR con l\'app DicaDoc\nper ricevere le terapie prescritte.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          SelectableText(
            'Server: $_serverUrl',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
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
