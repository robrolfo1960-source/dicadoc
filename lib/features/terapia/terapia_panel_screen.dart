import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/enums.dart';
import 'terapia_providers.dart';
import 'terapia_repository.dart';
import 'widgets/assunzione_sheet.dart';
import 'widgets/farmaco_card.dart';

/// Pannello P1: TERAPIA.
class TerapiaPanelScreen extends ConsumerStatefulWidget {
  const TerapiaPanelScreen({super.key});

  @override
  ConsumerState<TerapiaPanelScreen> createState() => _TerapiaPanelScreenState();
}

class _TerapiaPanelScreenState extends ConsumerState<TerapiaPanelScreen> {
  @override
  void initState() {
    super.initState();
    // Dopo il primo frame: permessi notifiche + pianificazione ALERT (F1).
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(notificationServiceProvider).requestPermissions();
      final pazienteId = ref.read(pazienteCorrenteIdProvider);
      await ref.read(terapiaRepositoryProvider).pianificaPromemoria(pazienteId);
    });
  }

  Future<void> _registra(DoseOggi dose, StatoAssunzione stato) async {
    await ref.read(terapiaRepositoryProvider).registraAssunzione(dose, stato);
    ref.invalidate(farmaciOggiProvider);
    if (!mounted) return;
    final messaggio = switch (stato) {
      StatoAssunzione.assunta => 'Assunzione confermata',
      StatoAssunzione.posticipata => 'Promemoria posticipato di 15 minuti',
      StatoAssunzione.rifiutata => 'Dose registrata come rifiutata',
      _ => 'Registrato',
    };
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(messaggio)));
  }

  @override
  Widget build(BuildContext context) {
    final farmaciAsync = ref.watch(farmaciOggiProvider);
    final oggi = DateFormat('EEEE d MMMM', 'it_IT').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('P1 - Terapia'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(farmaciOggiProvider),
        child: farmaciAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(
            children: [
              const SizedBox(height: 80),
              Center(child: Text('Errore: $e')),
            ],
          ),
          data: (farmaci) {
            if (farmaci.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('Nessuna terapia attiva.')),
                ],
              );
            }
            return ListView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                  child: Text(
                    'Le tue terapie di oggi - $oggi',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                ...farmaci.map(
                  (f) => FarmacoCard(
                    farmaco: f,
                    onTapDose: (dose) => AssunzioneSheet.mostra(
                      context,
                      dose: dose,
                      onScelta: (stato) => _registra(dose, stato),
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
