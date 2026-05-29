import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums.dart';
import '../../../data/db/database.dart';
import '../../terapia/terapia_providers.dart';
import '../monitora_providers.dart';

class MisurazioneSheet extends ConsumerStatefulWidget {
  const MisurazioneSheet({
    super.key,
    required this.parametro,
    required this.onSalvato,
  });

  final ParametroCatalogo parametro;
  final VoidCallback onSalvato;

  static Future<void> mostra(
    BuildContext context, {
    required ParametroCatalogo parametro,
    required VoidCallback onSalvato,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) =>
          MisurazioneSheet(parametro: parametro, onSalvato: onSalvato),
    );
  }

  @override
  ConsumerState<MisurazioneSheet> createState() => _MisurazioneSheetState();
}

class _MisurazioneSheetState extends ConsumerState<MisurazioneSheet> {
  final _ctrl1 = TextEditingController();
  final _ctrl2 = TextEditingController();
  final _ctrlTesto = TextEditingController();
  bool _salvando = false;

  @override
  void dispose() {
    _ctrl1.dispose();
    _ctrl2.dispose();
    _ctrlTesto.dispose();
    super.dispose();
  }

  Future<void> _salva() async {
    final p = widget.parametro;
    double? v1, v2;
    String? testo;

    if (p.tipoValore == TipoValore.testo) {
      testo = _ctrlTesto.text.trim();
      if (testo.isEmpty) return;
    } else {
      v1 = double.tryParse(_ctrl1.text.replaceAll(',', '.'));
      if (v1 == null) return;
      if (p.tipoValore == TipoValore.coppia) {
        v2 = double.tryParse(_ctrl2.text.replaceAll(',', '.'));
        if (v2 == null) return;
      }
    }

    setState(() => _salvando = true);
    try {
      final pazienteId = ref.read(pazienteCorrenteIdProvider);
      await ref.read(monitoraRepositoryProvider).aggiungiMisurazione(
            pazienteId: pazienteId,
            parametroId: p.id,
            valore1: v1,
            valore2: v2,
            valoreTesto: testo,
          );
      if (mounted) {
        Navigator.pop(context);
        widget.onSalvato();
      }
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.parametro;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            p.nomeVisualizzato,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(p.unitaMisura, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
          if (p.tipoValore == TipoValore.testo)
            TextField(
              controller: _ctrlTesto,
              autofocus: true,
              decoration: InputDecoration(
                labelText: p.etichettaValore1,
                border: const OutlineInputBorder(),
              ),
            )
          else if (p.tipoValore == TipoValore.coppia) ...[
            TextField(
              controller: _ctrl1,
              autofocus: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText:
                    '${p.etichettaValore1} (${p.unitaMisura})',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ctrl2,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _salva(),
              decoration: InputDecoration(
                labelText:
                    '${p.etichettaValore2 ?? p.etichettaValore1} (${p.unitaMisura})',
                border: const OutlineInputBorder(),
              ),
            ),
          ] else
            TextField(
              controller: _ctrl1,
              autofocus: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _salva(),
              decoration: InputDecoration(
                labelText: '${p.etichettaValore1} (${p.unitaMisura})',
                border: const OutlineInputBorder(),
              ),
            ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _salvando ? null : _salva,
            icon: _salvando
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.save_outlined),
            label: const Text('Salva'),
          ),
        ],
      ),
    );
  }
}
