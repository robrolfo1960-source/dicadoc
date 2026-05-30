import 'dart:io';

import 'package:drift/drift.dart';
import 'package:health/health.dart';

import '../../core/enums.dart';
import '../db/database.dart';
import '../sync/sync_service.dart';

/// Servizio F6: legge misurazioni da Google Health Connect / Apple HealthKit
/// e le inserisce in Misurazioni con fonteEffettiva = healthConnect.
class HealthConnectService {
  HealthConnectService(this._db, this._sync);

  final AppDatabase _db;
  final SyncService _sync;

  static const _tipi = [
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.WEIGHT,
  ];

  Future<bool> isDisponibile() async {
    // Su iOS 26 beta HealthKit.requestAuthorization lancia NSInvalidArgumentException
    // anche con NSHealthShareUsageDescription presente. Il servizio è stub su iOS.
    if (!Platform.isAndroid) return false;
    return await Health().isHealthConnectAvailable();
  }

  /// Importa le ultime [giorni] giornate da Health Connect.
  /// Restituisce il numero di nuove misurazioni inserite.
  Future<int> importa({required int pazienteId, int giorni = 30}) async {
    final health = Health();
    await health.configure();

    final permessi = List.filled(_tipi.length, HealthDataAccess.READ);
    final granted = await health.requestAuthorization(_tipi, permissions: permessi);
    if (!granted) throw Exception('Permessi Health Connect negati');

    final fine = DateTime.now();
    final inizio = fine.subtract(Duration(days: giorni));

    final dati = health.removeDuplicates(
      await health.getHealthDataFromTypes(
        startTime: inizio,
        endTime: fine,
        types: _tipi,
      ),
    );

    final catalogo = await _db.select(_db.catalogoParametri).get();
    final catMap = {for (final p in catalogo) p.codice: p};

    // Raggruppa sistolica/diastolica per timestamp
    final Map<String, _BpPair> pressioni = {};
    int count = 0;

    for (final d in dati) {
      final val = (d.value as NumericHealthValue).numericValue.toDouble();
      final tKey = d.dateFrom.toIso8601String();

      if (d.type == HealthDataType.BLOOD_PRESSURE_SYSTOLIC) {
        pressioni.putIfAbsent(tKey, _BpPair.new).sistolica = val;
        continue;
      }
      if (d.type == HealthDataType.BLOOD_PRESSURE_DIASTOLIC) {
        pressioni.putIfAbsent(tKey, _BpPair.new).diastolica = val;
        continue;
      }

      final codice = switch (d.type) {
        HealthDataType.BLOOD_GLUCOSE => 'glicemia',
        HealthDataType.WEIGHT => 'peso',
        _ => null,
      };
      if (codice == null) continue;

      final parametro = catMap[codice];
      if (parametro == null) continue;

      await _db.into(_db.misurazioni).insertOnConflictUpdate(
            MisurazioniCompanion.insert(
              pazienteId: pazienteId,
              parametroId: parametro.id,
              data: d.dateFrom,
              fonteEffettiva: FonteParametro.healthConnect,
              valore1: Value(val),
              sincronizzato: const Value(false),
            ),
          );
      count++;
    }

    // Salva coppie pressione
    final parametroPressione = catMap['pressione'];
    if (parametroPressione != null) {
      for (final entry in pressioni.entries) {
        final p = entry.value;
        if (p.sistolica == null || p.diastolica == null) continue;
        await _db.into(_db.misurazioni).insertOnConflictUpdate(
              MisurazioniCompanion.insert(
                pazienteId: pazienteId,
                parametroId: parametroPressione.id,
                data: DateTime.parse(entry.key),
                fonteEffettiva: FonteParametro.healthConnect,
                valore1: Value(p.sistolica),
                valore2: Value(p.diastolica),
                sincronizzato: const Value(false),
              ),
            );
        count++;
      }
    }

    if (count > 0) await _sync.push();
    return count;
  }
}

class _BpPair {
  double? sistolica;
  double? diastolica;
}
