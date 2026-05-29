import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/enums.dart';
import '../../../core/theme.dart';
import '../terapia_repository.dart';

class FarmacoCard extends StatelessWidget {
  const FarmacoCard({
    super.key,
    required this.farmaco,
    required this.onTapDose,
    this.onModifica,
    this.onDisattiva,
  });

  final FarmacoOggi farmaco;
  final void Function(DoseOggi dose) onTapDose;
  final VoidCallback? onModifica;
  final VoidCallback? onDisattiva;

  Color _colore(StatoFarmaco s) => switch (s) {
        StatoFarmaco.ok => AppTheme.statoOk,
        StatoFarmaco.attenzione => AppTheme.statoAttenzione,
        StatoFarmaco.allarme => AppTheme.statoAllarme,
      };

  // Emoticon: cuore/faccina verde sorridente vs rossa triste.
  IconData _emoticon(StatoFarmaco s) => switch (s) {
        StatoFarmaco.ok => Icons.sentiment_very_satisfied,
        StatoFarmaco.attenzione => Icons.sentiment_neutral,
        StatoFarmaco.allarme => Icons.sentiment_very_dissatisfied,
      };

  @override
  Widget build(BuildContext context) {
    final stato = farmaco.stato;
    final colore = _colore(stato);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_emoticon(stato), color: colore, size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        farmaco.terapia.nomeFarmaco,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${farmaco.terapia.dosaggio ?? ''}  -  ${farmaco.terapia.priorita.etichetta}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (farmaco.terapia.priorita.richiedeEscalation)
                  Tooltip(
                    message: 'Promemoria con sollecito ripetuto',
                    child: Icon(Icons.priority_high, color: colore),
                  ),
                if (onModifica != null || onDisattiva != null)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (v) {
                      if (v == 'modifica') onModifica?.call();
                      if (v == 'disattiva') onDisattiva?.call();
                    },
                    itemBuilder: (_) => [
                      if (onModifica != null)
                        const PopupMenuItem(
                          value: 'modifica',
                          child: ListTile(
                            leading: Icon(Icons.edit_outlined),
                            title: Text('Modifica'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      if (onDisattiva != null)
                        const PopupMenuItem(
                          value: 'disattiva',
                          child: ListTile(
                            leading: Icon(Icons.stop_circle_outlined),
                            title: Text('Disattiva'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: farmaco.dosi.map((d) => _chipDose(context, d)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chipDose(BuildContext context, DoseOggi dose) {
    final ora = DateFormat('HH:mm').format(dose.prevista);
    final (Color bg, Color fg, IconData icona) = switch (dose.stato) {
      StatoAssunzione.assunta => (
          AppTheme.statoOk.withValues(alpha: 0.15),
          AppTheme.statoOk,
          Icons.check_circle
        ),
      StatoAssunzione.posticipata => (
          AppTheme.statoAttenzione.withValues(alpha: 0.15),
          AppTheme.statoAttenzione,
          Icons.snooze
        ),
      StatoAssunzione.rifiutata || StatoAssunzione.nonAssunta => (
          AppTheme.statoAllarme.withValues(alpha: 0.15),
          AppTheme.statoAllarme,
          Icons.cancel
        ),
      StatoAssunzione.programmata => dose.inRitardo
          ? (
              AppTheme.statoAllarme.withValues(alpha: 0.15),
              AppTheme.statoAllarme,
              Icons.schedule
            )
          : (
              Colors.black.withValues(alpha: 0.06),
              Colors.black54,
              Icons.schedule
            ),
    };

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onTapDose(dose),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icona, size: 18, color: fg),
            const SizedBox(width: 6),
            Text(ora, style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
