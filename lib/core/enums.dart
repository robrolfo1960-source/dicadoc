/// Enumerazioni di dominio condivise da DB e UI.
///
/// Vengono memorizzate nel database come indice intero (drift `intEnum`),
/// quindi NON riordinare le voci esistenti: aggiungere sempre in coda.
library;

/// Tipo di valore di un parametro biometrico nel Catalogo Parametri.
enum TipoValore {
  singolo, // es. peso, glicemia
  coppia, // es. pressione (sistolica/diastolica)
  testo, // es. note libere
}

/// Da dove proviene un dato/parametro.
enum FonteParametro {
  manuale, // inserito dal paziente
  healthConnect, // Apple Health / Google Health Connect
  ocrReferto, // estratto da PDF di laboratorio
}

/// Priorita della terapia: modula l'invadenza dell'ALERT (F1).
enum PrioritaTerapia {
  integratore, // invadenza minima
  bassa,
  media,
  alta,
  salvavita, // massima invadenza + escalation notifiche
}

extension PrioritaTerapiaX on PrioritaTerapia {
  /// True se la terapia merita il "rilancio dell'allarme" (notifiche ripetute).
  bool get richiedeEscalation =>
      this == PrioritaTerapia.alta || this == PrioritaTerapia.salvavita;

  String get etichetta => switch (this) {
        PrioritaTerapia.integratore => 'Integratore',
        PrioritaTerapia.bassa => 'Priorita bassa',
        PrioritaTerapia.media => 'Priorita media',
        PrioritaTerapia.alta => 'Priorita alta',
        PrioritaTerapia.salvavita => 'Salvavita',
      };
}

/// Stato di una singola assunzione di farmaco.
enum StatoAssunzione {
  programmata, // dose attesa, non ancora gestita
  assunta, // confermata dal paziente
  posticipata, // "Posticipa 15 min"
  rifiutata, // es. per effetti collaterali
  nonAssunta, // timeout scaduto senza conferma
}

extension StatoAssunzioneX on StatoAssunzione {
  /// True se la dose e' stata gestita positivamente (display "verde").
  bool get isPositiva => this == StatoAssunzione.assunta;

  /// True se rappresenta un problema da evidenziare (display "rosso").
  bool get isCritica =>
      this == StatoAssunzione.rifiutata || this == StatoAssunzione.nonAssunta;
}
