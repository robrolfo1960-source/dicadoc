/// Astrazione del livello di sincronizzazione.
///
/// QUESTO E' IL PUNTO CHIAVE DELL'ARCHITETTURA.
/// Oggi (Fase 1) usiamo [LocalOnlySync]: tutto resta sul device, nessuna rete.
/// Quando attiveremo il cloud (Fase 3) basta fornire una seconda
/// implementazione (es. `CloudSync` verso una VPS Oracle/PocketBase/Supabase)
/// SENZA modificare repository, UI o schema: le righe hanno gia' il flag
/// `sincronizzato`, quindi il passaggio "opzione 3 -> opzione 1" e' indolore.
abstract class SyncService {
  /// True se e' configurato un backend remoto raggiungibile.
  bool get isCloudEnabled;

  /// Invia al server le righe locali non ancora sincronizzate.
  Future<void> push();

  /// Recupera dal server gli aggiornamenti (es. nuove terapie dal MMG).
  Future<void> pull();
}

/// Implementazione Fase 1: nessuna rete, sync no-op.
/// I dati restano sul device finche' non si abilita il cloud.
class LocalOnlySync implements SyncService {
  const LocalOnlySync();

  @override
  bool get isCloudEnabled => false;

  @override
  Future<void> push() async {
    // No-op: in Fase 3 qui leggeremo le righe con sincronizzato == false
    // (es. db.assunzioni, db.misurazioni), le invieremo al backend e
    // imposteremo sincronizzato = true.
  }

  @override
  Future<void> pull() async {
    // No-op: in Fase 3 qui scaricheremo terapie/obiettivi impostati dal MMG.
  }
}

/// Bozza di firma per la futura implementazione cloud (NON usata in Fase 1).
/// Lasciata come traccia di sviluppo.
// class CloudSync implements SyncService {
//   CloudSync(this._db, this._endpoint);
//   final AppDatabase _db;
//   final Uri _endpoint;
//   @override
//   bool get isCloudEnabled => true;
//   @override
//   Future<void> push() async { /* invia righe sincronizzato == false */ }
//   @override
//   Future<void> pull() async { /* scarica aggiornamenti dal MMG */ }
// }
