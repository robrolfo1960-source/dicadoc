import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'monitora_providers.dart';
import 'widgets/misurazione_sheet.dart';
import 'widgets/parametro_card.dart';

class MonitoraPanelScreen extends ConsumerWidget {
  const MonitoraPanelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parametriAsync = ref.watch(parametriAbilitatiProvider);
    final oggi = DateFormat('EEEE d MMMM', 'it_IT').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('P2 - Monitora')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(parametriAbilitatiProvider),
        child: parametriAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: 80),
              Center(child: Text('Errore: $e')),
            ],
          ),
          data: (parametri) {
            if (parametri.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('Nessun parametro abilitato.')),
                ],
              );
            }
            return ListView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                  child: Text(
                    'Monitoraggio - $oggi',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                ...parametri.map(
                  (p) => ParametroCard(
                    parametro: p,
                    onAggiungi: () => MisurazioneSheet.mostra(
                      context,
                      parametro: p.parametro,
                      onSalvato: () =>
                          ref.invalidate(parametriAbilitatiProvider),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
