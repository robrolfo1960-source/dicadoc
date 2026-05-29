import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme.dart';
import '../monitora_repository.dart';

class ParametroCard extends StatelessWidget {
  const ParametroCard({
    super.key,
    required this.parametro,
    required this.onAggiungi,
  });

  final ParametroConValore parametro;
  final VoidCallback onAggiungi;

  Color _colore(StatoMisurazione s) => switch (s) {
        StatoMisurazione.ok => AppTheme.statoOk,
        StatoMisurazione.attenzione => AppTheme.statoAttenzione,
        StatoMisurazione.allarme => AppTheme.statoAllarme,
        StatoMisurazione.nonDisponibile => Colors.black38,
      };

  @override
  Widget build(BuildContext context) {
    final stato = parametro.stato;
    final colore = _colore(stato);
    final m = parametro.ultimaMisurazione;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onAggiungi,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(color: colore, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parametro.parametro.nomeVisualizzato,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    if (m != null) ...[
                      Text(
                        '${parametro.valoreFormattato} ${parametro.parametro.unitaMisura}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: colore,
                        ),
                      ),
                      Text(
                        DateFormat('d MMM yyyy HH:mm', 'it_IT').format(m.data),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ] else
                      Text(
                        'Nessuna misurazione registrata',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54),
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onAggiungi,
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Aggiungi misurazione',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
