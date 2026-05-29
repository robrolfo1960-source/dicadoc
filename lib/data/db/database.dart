import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/enums.dart';

part 'database.g.dart';

// ---------------------------------------------------------------------------
// SCHEMA COMPLETO
//
// Nota sulla pseudonimizzazione (GDPR art. 9): sul SERVER e nelle tabelle
// cliniche l'identita' del paziente deve essere scollegata dai dati clinici
// (solo paziente_id). L'associazione id <-> Nome/CF risiede idealmente solo
// sul computer del MMG. La tabella Pazienti qui sotto serve al device locale
// (che conosce il proprio assistito); in fase di sync verso il cloud NON
// verra' inviata l'anagrafica, ma solo le righe collegate via pazienteId.
// ---------------------------------------------------------------------------

@DataClassName('Paziente')
class Pazienti extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cognome => text()(); // obbligatorio
  TextColumn get nome => text()(); // obbligatorio
  TextColumn get codiceFiscale => text().withLength(min: 11, max: 16)();
  DateTimeColumn get dataNascita => dateTime()(); // ricavabile dal CF
  TextColumn get indirizzo => text().nullable()();
  TextColumn get telefono => text().nullable()();
  TextColumn get cellulare => text()(); // obbligatorio
  TextColumn get email => text().nullable()();
  // "Anni" NON e' memorizzato: si calcola da dataNascita (vedi PazienteX).
}

extension PazienteX on Paziente {
  int get anni {
    final now = DateTime.now();
    var eta = now.year - dataNascita.year;
    final compleannoPassato = (now.month > dataNascita.month) ||
        (now.month == dataNascita.month && now.day >= dataNascita.day);
    if (!compleannoPassato) eta--;
    return eta;
  }
}

@DataClassName('Patologia')
class Patologie extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pazienteId => integer().references(Pazienti, #id)();
  TextColumn get nome => text()();
}

@DataClassName('RispostaAnamnesi')
class RisposteAnamnesi extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pazienteId => integer().references(Pazienti, #id)();
  TextColumn get domanda => text()();
  BoolColumn get risposta => boolean()();
}

// --- Architettura DB estensibile (Catalogo / Misurazioni / Template) ---

@DataClassName('ParametroCatalogo')
class CatalogoParametri extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nomeVisualizzato => text()(); // "Pressione Arteriosa"
  TextColumn get codice => text().unique()(); // "pressione"
  TextColumn get unitaMisura => text()(); // "mmHg"
  IntColumn get tipoValore => intEnum<TipoValore>()();
  TextColumn get etichettaValore1 => text()(); // "Sistolica" / "Valore"
  TextColumn get etichettaValore2 => text().nullable()(); // "Diastolica"
  RealColumn get sogliaNormaleMin => real().nullable()();
  RealColumn get sogliaNormaleMax => real().nullable()();
  RealColumn get sogliaAttenzioneMax => real().nullable()();
  RealColumn get sogliaAllarmeMax => real().nullable()();
  IntColumn get fonte => intEnum<FonteParametro>()();
  IntColumn get ordineVisualizzazione =>
      integer().withDefault(const Constant(0))();
  BoolColumn get attivo => boolean().withDefault(const Constant(true))();
}

/// Join: quali parametri del catalogo sono abilitati per quale paziente
/// (corrisponde a "attivo_per_paziente[]" del documento).
@DataClassName('ParametroAbilitato')
class ParametriAbilitati extends Table {
  IntColumn get pazienteId => integer().references(Pazienti, #id)();
  IntColumn get parametroId => integer().references(CatalogoParametri, #id)();

  @override
  Set<Column> get primaryKey => {pazienteId, parametroId};
}

@DataClassName('Misurazione')
class Misurazioni extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pazienteId => integer().references(Pazienti, #id)();
  IntColumn get parametroId => integer().references(CatalogoParametri, #id)();
  RealColumn get valore1 => real().nullable()();
  RealColumn get valore2 => real().nullable()();
  TextColumn get valoreTesto => text().nullable()();
  DateTimeColumn get data => dateTime()();
  IntColumn get fonteEffettiva => intEnum<FonteParametro>()();
  BoolColumn get sincronizzato => boolean().withDefault(const Constant(false))();
}

@DataClassName('TemplateReferto')
class TemplateReferti extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nomeLaboratorio => text()();
  IntColumn get parametroId => integer().references(CatalogoParametri, #id)();
  TextColumn get patternRicerca => text()(); // stringa o regex per OCR
  IntColumn get posizioneValore => integer().withDefault(const Constant(0))();
}

// --- Terapie / Orari / Assunzioni (cuore di F1 + P1) ---

@DataClassName('Terapia')
class Terapie extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pazienteId => integer().references(Pazienti, #id)();
  IntColumn get patologiaId =>
      integer().nullable().references(Patologie, #id)();
  TextColumn get nomeFarmaco => text()();
  TextColumn get dosaggio => text().nullable()(); // "10 mg", "1 compressa"
  IntColumn get priorita => intEnum<PrioritaTerapia>()();
  TextColumn get fotoBlisterPath => text().nullable()(); // "Fotografa il Blister"
  BoolColumn get attiva => boolean().withDefault(const Constant(true))();
  DateTimeColumn get dataInizio => dateTime()();
  DateTimeColumn get dataFine => dateTime().nullable()();
  TextColumn get note => text().nullable()();
}

@DataClassName('OrarioTerapia')
class OrariTerapia extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get terapiaId => integer().references(Terapie, #id)();
  TextColumn get ora => text()(); // formato "HH:mm"
}

@DataClassName('Assunzione')
class Assunzioni extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get terapiaId => integer().references(Terapie, #id)();
  IntColumn get orarioId =>
      integer().nullable().references(OrariTerapia, #id)();
  DateTimeColumn get dataOraPrevista => dateTime()();
  DateTimeColumn get dataOraRegistrazione => dateTime().nullable()();
  IntColumn get stato => intEnum<StatoAssunzione>()();
  TextColumn get note => text().nullable()();
  BoolColumn get sincronizzato => boolean().withDefault(const Constant(false))();
}

// ---------------------------------------------------------------------------
// DATABASE
// ---------------------------------------------------------------------------

@DriftDatabase(tables: [
  Pazienti,
  Patologie,
  RisposteAnamnesi,
  CatalogoParametri,
  ParametriAbilitati,
  Misurazioni,
  TemplateReferti,
  Terapie,
  OrariTerapia,
  Assunzioni,
])
class AppDatabase extends _$AppDatabase {
  // Fase 3: il DB è cifrato con SQLCipher; la passphrase viene da CryptoService.
  AppDatabase(String passphrase) : super(_openConnection(passphrase));

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  /// Numero di pazienti registrati (per decidere se eseguire il seed).
  Future<int> contaPazienti() async {
    final rows = await select(pazienti).get();
    return rows.length;
  }
}

LazyDatabase _openConnection(String passphrase) {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    // Fase 3: nuovo file cifrato. Il vecchio 'dicadoc.sqlite' in chiaro
    // (Fase 1/2) viene ignorato; il seed ricrea i dati demo al primo avvio.
    final file = File(p.join(dir.path, 'dicadoc_v3.sqlite'));
    return NativeDatabase.createInBackground(
      file,
      setup: (db) => db.execute("PRAGMA key = '$passphrase'"),
    );
  });
}
