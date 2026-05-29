import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/enums.dart';
import '../../../core/theme.dart';
import '../terapia_repository.dart';

/// Foglio di conferma assunzione. Le tre azioni del documento sono esplicite
/// per rendere "sicura" la pressione dell'icona.
class AssunzioneSheet extends StatelessWidget {
  const AssunzioneSheet({super.key, required this.dose, required this.onScelta});

  final DoseOggi dose;
  final void Function(StatoAssunzione stato) onScelta;

  static Future<void> mostra(
    BuildContext context, {
    required DoseOggi dose,
    required void Function(StatoAssunzione stato) onScelta,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => AssunzioneSheet(dose: dose, onScelta: onScelta),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ora = DateFormat('HH:mm').format(dose.prevista);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            dose.terapia.nomeFarmaco,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${dose.terapia.dosaggio ?? ''}  -  dose delle $ora',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.statoOk),
            onPressed: () {
              Navigator.pop(context);
              onScelta(StatoAssunzione.assunta);
            },
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Assunto'),
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            style:
                FilledButton.styleFrom(backgroundColor: AppTheme.statoAttenzione),
            onPressed: () {
              Navigator.pop(context);
              onScelta(StatoAssunzione.posticipata);
            },
            icon: const Icon(Icons.snooze),
            label: const Text('Posticipa di 15 min'),
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            style:
                FilledButton.styleFrom(backgroundColor: AppTheme.statoAllarme),
            onPressed: () {
              Navigator.pop(context);
              onScelta(StatoAssunzione.rifiutata);
            },
            icon: const Icon(Icons.do_not_disturb_on_outlined),
            label: const Text('Rifiutato (es. effetti collaterali)'),
          ),
        ],
      ),
    );
  }
}
