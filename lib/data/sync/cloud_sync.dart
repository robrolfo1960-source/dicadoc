import 'sync_service.dart';

/// Implementazione cloud del layer di sincronizzazione (F2 SYNC).
///
/// Attivata quando AppConfig.getServerUrl() restituisce un valore non nullo.
/// Le chiamate HTTP verso il backend (PocketBase / Supabase) vanno
/// implementate qui in Fase 3+: per ora log-only.
class CloudSync implements SyncService {
  const CloudSync(this._serverUrl);
  // ignore: unused_field
  final String _serverUrl;

  @override
  bool get isCloudEnabled => true;

  @override
  Future<void> push() async {
    // TODO(Fase 3+): invia a $_serverUrl le righe con sincronizzato = false
    // (assunzioni, misurazioni). Imposta sincronizzato = true dopo ACK.
    // Libreria consigliata: package:http  oppure  package:pocketbase.
  }

  @override
  Future<void> pull() async {
    // TODO(Fase 3+): scarica da $_serverUrl terapie e obiettivi
    // aggiornati dal MMG, merge locale senza sovrascrivere dati non inviati.
  }
}
