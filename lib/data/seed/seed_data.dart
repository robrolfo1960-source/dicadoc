import 'package:drift/drift.dart';

import '../../core/enums.dart';
import '../db/database.dart';

/// Popola il database con dati di esempio al primo avvio (se vuoto).
///
/// Crea un paziente, alcuni parametri di catalogo, due terapie con orari e
/// qualche assunzione di oggi: una dose del mattino NON confermata (display
/// rosso) e dosi future ancora programmate (display verde).
Future<void> seedIfEmpty(AppDatabase db) async {
  final esistenti = await db.contaPazienti();
  if (esistenti > 0) return;

  final now = DateTime.now();
  final oggi = DateTime(now.year, now.month, now.day);

  await db.transaction(() async {
    // --- Paziente di esempio ---
    final pazienteId = await db.into(db.pazienti).insert(
          PazientiCompanion.insert(
            cognome: 'Rossi',
            nome: 'Mario',
            codiceFiscale: 'RSSMRA50A01L219X',
            dataNascita: DateTime(1950, 1, 1),
            cellulare: '3331234567',
            indirizzo: const Value('Via Roma 1, Torino'),
            email: const Value('mario.rossi@example.it'),
          ),
        );

    // --- Patologie ---
    final ipertensioneId = await db.into(db.patologie).insert(
          PatologieCompanion.insert(pazienteId: pazienteId, nome: 'Ipertensione'),
        );
    await db.into(db.patologie).insert(
          PatologieCompanion.insert(
              pazienteId: pazienteId, nome: 'Diabete mellito tipo 2'),
        );

    // --- Catalogo parametri (base estensibile) ---
    await db.batch((b) {
      b.insertAll(db.catalogoParametri, [
        CatalogoParametriCompanion.insert(
          nomeVisualizzato: 'Pressione Arteriosa',
          codice: 'pressione',
          unitaMisura: 'mmHg',
          tipoValore: TipoValore.coppia,
          etichettaValore1: 'Sistolica',
          etichettaValore2: const Value('Diastolica'),
          sogliaNormaleMax: const Value(140.0),
          sogliaAttenzioneMax: const Value(160.0),
          sogliaAllarmeMax: const Value(180.0),
          fonte: FonteParametro.manuale,
          ordineVisualizzazione: const Value(1),
        ),
        CatalogoParametriCompanion.insert(
          nomeVisualizzato: 'Peso',
          codice: 'peso',
          unitaMisura: 'kg',
          tipoValore: TipoValore.singolo,
          etichettaValore1: 'Valore',
          fonte: FonteParametro.manuale,
          ordineVisualizzazione: const Value(2),
        ),
        CatalogoParametriCompanion.insert(
          nomeVisualizzato: 'Glicemia',
          codice: 'glicemia',
          unitaMisura: 'mg/dL',
          tipoValore: TipoValore.singolo,
          etichettaValore1: 'Valore',
          sogliaNormaleMax: const Value(126.0),
          sogliaAttenzioneMax: const Value(180.0),
          sogliaAllarmeMax: const Value(250.0),
          fonte: FonteParametro.manuale,
          ordineVisualizzazione: const Value(3),
        ),
      ]);
    });

    // --- Terapia 1: salvavita, due assunzioni al giorno ---
    final ramiprilId = await db.into(db.terapie).insert(
          TerapieCompanion.insert(
            pazienteId: pazienteId,
            nomeFarmaco: 'Ramipril',
            dosaggio: const Value('5 mg'),
            priorita: PrioritaTerapia.salvavita,
            dataInizio: oggi,
            patologiaId: Value(ipertensioneId),
            note: const Value('Per la pressione. Da assumere a stomaco pieno.'),
          ),
        );
    final ramiprilOra1 = await db.into(db.orariTerapia).insert(
          OrariTerapiaCompanion.insert(terapiaId: ramiprilId, ora: '08:00'),
        );
    final ramiprilOra2 = await db.into(db.orariTerapia).insert(
          OrariTerapiaCompanion.insert(terapiaId: ramiprilId, ora: '20:00'),
        );

    // --- Terapia 2: integratore, una volta al giorno ---
    final vitDId = await db.into(db.terapie).insert(
          TerapieCompanion.insert(
            pazienteId: pazienteId,
            nomeFarmaco: 'Vitamina D',
            dosaggio: const Value('1000 UI'),
            priorita: PrioritaTerapia.integratore,
            dataInizio: oggi,
          ),
        );
    final vitDOra = await db.into(db.orariTerapia).insert(
          OrariTerapiaCompanion.insert(terapiaId: vitDId, ora: '13:00'),
        );

    // --- Assunzioni di oggi (per mostrare stati diversi nel pannello) ---
    // Dose Ramipril delle 08:00: NON confermata -> display rosso/triste.
    await db.into(db.assunzioni).insert(
          AssunzioniCompanion.insert(
            terapiaId: ramiprilId,
            orarioId: Value(ramiprilOra1),
            dataOraPrevista: oggi.add(const Duration(hours: 8)),
            stato: StatoAssunzione.programmata,
          ),
        );
    // Le dosi delle 13:00 e 20:00 NON le inseriamo qui: verranno create alla
    // prima interazione / scheduling, restando "future" -> display verde.
    // (orari di riferimento mantenuti per chiarezza)
    assert(ramiprilOra2 > 0 && vitDOra > 0);
  });
}
