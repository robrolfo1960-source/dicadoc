import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';
import '../../data/db/database.dart';
import 'pazienti_providers.dart';
import 'paziente_detail_screen.dart';
import 'widgets/paziente_form_sheet.dart';

class MedicoHomeScreen extends ConsumerWidget {
  const MedicoHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pazientiAsync = ref.watch(listaPazientiProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('I miei pazienti'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Aggiorna lista',
            onPressed: () => ref.invalidate(listaPazientiProvider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'medico_fab',
        onPressed: () async {
          final ok = await PazienteFormSheet.mostra(context);
          if (ok) ref.invalidate(listaPazientiProvider);
        },
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Nuovo paziente'),
      ),
      body: pazientiAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Errore: $e')),
        data: (pazienti) {
          if (pazienti.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.people_outline, size: 72, color: Colors.black26),
                  const SizedBox(height: 16),
                  Text('Nessun paziente registrato',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const Text(
                    'Premi "Nuovo paziente" per aggiungere\nil primo assistito.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: pazienti.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) => _PazienteCard(
              paziente: pazienti[i],
              onTap: () => Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (_) => PazienteDetailScreen(paziente: pazienti[i]),
                ),
              ).then((_) => ref.invalidate(listaPazientiProvider)),
              onElimina: () async {
                final ok = await showDialog<bool>(
                  context: ctx,
                  builder: (d) => AlertDialog(
                    title: const Text('Elimina paziente'),
                    content: Text(
                        'Eliminare ${pazienti[i].nome} ${pazienti[i].cognome} e tutti i suoi dati?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(d, false),
                          child: const Text('Annulla')),
                      FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () => Navigator.pop(d, true),
                          child: const Text('Elimina')),
                    ],
                  ),
                );
                if (ok == true) {
                  await ref
                      .read(pazientiRepositoryProvider)
                      .eliminaPaziente(pazienti[i].id);
                  ref.invalidate(listaPazientiProvider);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class _PazienteCard extends StatelessWidget {
  const _PazienteCard({
    required this.paziente,
    required this.onTap,
    this.onElimina,
  });

  final Paziente paziente;
  final VoidCallback onTap;
  final VoidCallback? onElimina;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM yyyy', 'it_IT');
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppTheme.brand.withValues(alpha: 0.12),
          child: Text(
            '${paziente.nome[0]}${paziente.cognome[0]}',
            style: TextStyle(
              color: AppTheme.brand,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '${paziente.cognome} ${paziente.nome}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'CF: ${paziente.codiceFiscale}  ·  '
          'Nato/a il ${fmt.format(paziente.dataNascita)} (${paziente.anni} anni)',
        ),
        trailing: onElimina != null
            ? PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (v) { if (v == 'elimina') onElimina!(); },
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'elimina',
                    child: ListTile(
                      leading: Icon(Icons.delete_outline, color: Colors.red),
                      title: Text('Elimina', style: TextStyle(color: Colors.red)),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              )
            : const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
