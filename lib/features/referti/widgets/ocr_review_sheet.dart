import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums.dart';
import '../../../core/theme.dart';
import '../../terapia/terapia_providers.dart';
import '../referti_providers.dart';
import '../referti_repository.dart';

class OcrReviewSheet extends ConsumerStatefulWidget {
  const OcrReviewSheet({
    super.key,
    required this.valori,
    required this.onSalvato,
  });

  final List<ValoreEstratto> valori;
  final VoidCallback onSalvato;

  static Future<void> mostra(
    BuildContext context, {
    required List<ValoreEstratto> valori,
    required VoidCallback onSalvato,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => OcrReviewSheet(valori: valori, onSalvato: onSalvato),
    );
  }

  @override
  ConsumerState<OcrReviewSheet> createState() => _OcrReviewSheetState();
}

class _OcrReviewSheetState extends ConsumerState<OcrReviewSheet> {
  late final List<_RowState> _righe;
  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _righe = widget.valori.map((v) => _RowState(v)).toList();
  }

  @override
  void dispose() {
    for (final r in _righe) {
      r.ctrl1.dispose();
      r.ctrl2.dispose();
    }
    super.dispose();
  }

  Future<void> _salva() async {
    setState(() => _salvando = true);
    try {
      // Aggiorna i valori dai controller prima di salvare.
      for (final r in _righe) {
        if (!r.includi) continue;
        r.valore.valore1 =
            double.tryParse(r.ctrl1.text.replaceAll(',', '.'));
        if (r.valore.parametro.tipoValore == TipoValore.coppia) {
          r.valore.valore2 =
              double.tryParse(r.ctrl2.text.replaceAll(',', '.'));
        }
      }
      final daIncludere = _righe
          .where((r) => r.includi && r.valore.valore1 != null)
          .map((r) => r.valore)
          .toList();

      final repo = ref.read(refertiRepositoryProvider);
      final pazienteId = ref.read(pazienteCorrenteIdProvider);
      await repo.salva(pazienteId: pazienteId, valori: daIncludere);

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
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Valori rilevati',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Verifica e correggi prima di salvare',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          if (_righe.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text('Nessun valore rilevato nel referto.'),
              ),
            )
          else
            ..._righe.map((r) => _ValoreRow(riga: r, onChanged: () => setState(() {}))),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _salvando || _righe.every((r) => !r.includi)
                ? null
                : _salva,
            icon: _salvando
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(_righe.isEmpty ? 'Chiudi' : 'Salva misurazioni'),
          ),
        ],
      ),
    );
  }
}

class _RowState {
  _RowState(this.valore)
      : ctrl1 = TextEditingController(
            text: valore.valore1 != null
                ? (valore.valore1! % 1 == 0
                    ? valore.valore1!.toStringAsFixed(0)
                    : valore.valore1!.toStringAsFixed(1))
                : ''),
        ctrl2 = TextEditingController(
            text: valore.valore2 != null
                ? valore.valore2!.toStringAsFixed(0)
                : '');

  final ValoreEstratto valore;
  final TextEditingController ctrl1;
  final TextEditingController ctrl2;
  bool includi = true;
}

class _ValoreRow extends StatelessWidget {
  const _ValoreRow({required this.riga, required this.onChanged});

  final _RowState riga;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final p = riga.valore.parametro;
    final isCoppia = p.tipoValore == TipoValore.coppia;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: riga.includi,
              activeColor: AppTheme.brand,
              onChanged: (v) {
                riga.includi = v ?? true;
                onChanged();
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${p.nomeVisualizzato}  (${p.unitaMisura})',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppTheme.brand),
                  ),
                  const SizedBox(height: 8),
                  if (isCoppia)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: riga.ctrl1,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(
                              labelText: p.etichettaValore1,
                              isDense: true,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: riga.ctrl2,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(
                              labelText: p.etichettaValore2 ?? p.etichettaValore1,
                              isDense: true,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: riga.ctrl1,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: p.etichettaValore1,
                        isDense: true,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
