import 'package:drift/drift.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../core/enums.dart';
import '../../data/db/database.dart';
import '../../data/sync/sync_service.dart';

/// Valore estratto da OCR per un singolo parametro biometrico.
class ValoreEstratto {
  ValoreEstratto({
    required this.parametro,
    this.valore1,
    this.valore2,
    this.testoRaw = '',
  });

  final ParametroCatalogo parametro;
  double? valore1;
  double? valore2;
  final String testoRaw;

  String get label {
    if (parametro.tipoValore == TipoValore.coppia) {
      final v1 = valore1?.toStringAsFixed(0) ?? '?';
      final v2 = valore2?.toStringAsFixed(0) ?? '?';
      return '$v1 / $v2 ${parametro.unitaMisura}';
    }
    final v = valore1;
    if (v == null) return '—';
    return '${v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(1)} ${parametro.unitaMisura}';
  }
}

class RefertiRepository {
  RefertiRepository(this._db, this._sync);

  final AppDatabase _db;
  final SyncService _sync;

  /// Esegue OCR sull'immagine e applica i pattern da TemplateReferti.
  /// Restituisce i valori trovati (già raggruppati per parametro).
  Future<List<ValoreEstratto>> estraiDaImmagine(String imagePath) async {
    // 1. OCR
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognized = await recognizer.processImage(inputImage);
    await recognizer.close();
    final testo = recognized.text;

    // 2. Carica templates e catalogo
    final templates = await _db.select(_db.templateReferti).get();
    final catalogo = await _db.select(_db.catalogoParametri).get();
    final catalogoMap = {for (final p in catalogo) p.id: p};

    // 3. Applica ogni pattern
    final Map<int, ValoreEstratto> risultati = {};

    for (final tmpl in templates) {
      final parametro = catalogoMap[tmpl.parametroId];
      if (parametro == null) continue;

      final pattern = RegExp(tmpl.patternRicerca, caseSensitive: false, dotAll: true);
      final match = pattern.firstMatch(testo);
      if (match == null || match.groupCount < tmpl.posizioneValore + 1) continue;

      final raw = match.group(tmpl.posizioneValore + 1)?.replaceAll(',', '.');
      final val = raw != null ? double.tryParse(raw) : null;
      if (val == null) continue;

      risultati.putIfAbsent(
        tmpl.parametroId,
        () => ValoreEstratto(parametro: parametro, testoRaw: testo),
      );

      if (tmpl.posizioneValore == 0) {
        risultati[tmpl.parametroId]!.valore1 = val;
      } else {
        risultati[tmpl.parametroId]!.valore2 = val;
      }
    }

    return risultati.values.where((v) => v.valore1 != null).toList();
  }

  /// Salva i valori confermati in Misurazioni con fonte = ocrReferto.
  Future<void> salva({
    required int pazienteId,
    required List<ValoreEstratto> valori,
  }) async {
    final now = DateTime.now();
    await _db.batch((b) {
      for (final v in valori) {
        if (v.valore1 == null) continue;
        b.insert(
          _db.misurazioni,
          MisurazioniCompanion.insert(
            pazienteId: pazienteId,
            parametroId: v.parametro.id,
            data: now,
            fonteEffettiva: FonteParametro.ocrReferto,
            valore1: Value(v.valore1),
            valore2: Value(v.valore2),
            sincronizzato: const Value(false),
          ),
        );
      }
    });
    await _sync.push();
  }

  /// Storico import OCR: misurazioni con fonte = ocrReferto.
  Future<List<Misurazione>> storicoOcr(int pazienteId, {int limit = 20}) async {
    return (_db.select(_db.misurazioni)
          ..where((m) =>
              m.pazienteId.equals(pazienteId) &
              m.fonteEffettiva.equals(FonteParametro.ocrReferto.index))
          ..orderBy(
              [(m) => OrderingTerm(expression: m.data, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }
}
