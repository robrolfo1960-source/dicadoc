# DicaDoc / PMMC — Roadmap

**DicaDoc** (PMMC — Progetto Monitoraggio Medico del Cittadino) è una suite Flutter
per l'aderenza terapeutica e il monitoraggio remoto del paziente cronico.

---

## Notazione

| Prefisso | Significato |
|---|---|
| **F** | Feature trasversale (logica, servizi, infrastruttura) |
| **P** | Pannello (schermata UI visibile al paziente) |

---

## Architettura

```
lib/
├── core/               enum di dominio, tema
├── data/
│   ├── db/             schema Drift completo (v1) — non cambia nelle fasi 2-5
│   ├── seed/           dati di esempio al primo avvio
│   └── sync/           SyncService: LocalOnlySync (Fase 1-2) → CloudSync (Fase 3+)
└── features/
    ├── alert/          F1: ALERT
    ├── terapia/        P1: TERAPIA
    └── monitora/       P2: MONITORA
```

Lo schema DB è già completo dalla Fase 1: Pazienti, Patologie, Anamnesi, Catalogo
Parametri, Misurazioni, Template Referti, Terapie, Orari, Assunzioni.
Le fasi successive aggiungono **solo schermate e servizi**, non toccano lo schema.

---

## Fasi

### ✅ Fase 1 — Prototipo offline (COMPLETATA)

**F1 ALERT** — Notifiche locali per i promemoria farmaci
- Pianificazione giornaliera ricorrente per ogni dose
- Escalation: fino a 3 solleciti ravvicinati (5 min) per farmaci ad alta priorità / salvavita
- Annullamento automatico dei promemoria al momento dell'interazione
- "Posticipa 15 min": nuovo promemoria one-shot

**P1 TERAPIA** — Pannello dosi giornaliere
- Card per farmaco con emoticon semaforo (😊 ok / 😐 attenzione / 😢 allarme)
- Chip per ogni orario dose: grigio (programmata), rosso (in ritardo), verde (assunta), giallo (posticipata)
- Bottom sheet con tre azioni: Assunto / Posticipa 15 min / Rifiutato
- Dati persistiti su SQLite locale (Drift)
- Layer di sincronizzazione predisposto (`SyncService`, flag `sincronizzato` su ogni riga)

---

### ✅ Fase 2 — Monitoraggio biometrico manuale (COMPLETATA)

**P2 MONITORA** — Inserimento e visualizzazione misurazioni
- Card per ogni parametro abilitato (pressione, peso, glicemia, …)
- Pallino semaforo: verde / giallo / rosso in base alle soglie del catalogo
- Ultimo valore + data e ora misurazione
- Bottom sheet di inserimento:
  - Campo singolo (peso, glicemia)
  - Due campi (pressione: sistolica + diastolica)
  - Campo testo (note libere)
- Catalogo parametri estensibile (tabella `CatalogoParametri`)
- NavigationBar Material 3 con tab Terapia / Monitora

---

### 🔲 Fase 3 — Cloud, GDPR e onboarding QR

**F2 SYNC** — Sincronizzazione cloud local-first
- Implementazione `CloudSync implements SyncService`
- Invio al backend delle righe con `sincronizzato = false` (assunzioni, misurazioni)
- Ricezione terapie e obiettivi impostati dal MMG
- Backend suggerito: VPS Oracle Always Free (regione Milano) con PocketBase, oppure Supabase free tier EU

**F3 GDPR** — Cifratura del database locale
- Sostituzione di `NativeDatabase` con `SQLCipher` (sqlcipher_flutter_libs)
- Passphrase recuperata da `flutter_secure_storage`
- Pseudonimizzazione: l'anagrafica (`Pazienti`) rimane solo sul device; il cloud riceve solo `paziente_id`

**F4 ONBOARDING QR** — Collegamento paziente ↔ MMG
- Scansione QR generato dal portale del medico
- Imposta `pazienteCorrenteIdProvider` con l'id reale (oggi fisso = 1)
- Abilita parametri di monitoraggio prescritti dal MMG
- Autenticazione e provisioning del device

---

### 🔲 Fase 4 — Import referti di laboratorio (OCR)

**F5 OCR** — Lettura automatica PDF/immagini di referti
- Utilizzo di `TemplateReferti`: pattern di ricerca per ogni parametro / laboratorio
- Estrazione valori con regex o ML on-device
- Inserimento automatico in `Misurazioni` con `fonteEffettiva = FonteParametro.ocrReferto`
- Validazione manuale prima del salvataggio definitivo

**P3 REFERTI** — Pannello import referti
- Selezione PDF / scatto foto
- Anteprima dei valori estratti con highlight
- Conferma o correzione prima del salvataggio
- Storico referti importati

---

### 🔲 Fase 5 — Integrazione Health Connect / Apple Health e anamnesi

**F6 HEALTH CONNECT** — Integrazione con le piattaforme di salute del SO
- Lettura automatica di misurazioni da Google Health Connect (Android) / Apple HealthKit (iOS)
- Inserimento in `Misurazioni` con `fonteEffettiva = FonteParametro.healthConnect`
- Sincronizzazione periodica in background

**P4 ANAMNESI** — Questionario anamnestico iniziale
- Elenco domande (tabella `RisposteAnamnesi`)
- Condivisione con il MMG via cloud (Fase 3+)

**P5 PROFILO PAZIENTE** — Scheda anagrafica e patologie
- Visualizzazione e modifica dati `Pazienti`
- Lista patologie (`Patologie`) con farmaci associati
- Gestione terapie: aggiunta / modifica / disattivazione

---

## Stack tecnico

| Componente | Libreria |
|---|---|
| UI | Flutter 3.44 + Material 3 |
| Stato | Riverpod 3 |
| Database locale | Drift 2.16 (SQLite) |
| Cifratura (Fase 3) | sqlcipher_flutter_libs |
| Notifiche locali | flutter_local_notifications 21 |
| Timezone | flutter_timezone 5 + timezone |
| Date format | intl |
| Routing percorsi file | path + path_provider |

---

## Decisioni architetturali chiave

- **Local-first**: tutti i dati risiedono prima sul device; il cloud è un'opzione aggiuntiva,
  non un requisito. L'app è pienamente funzionale offline.
- **Schema stabile**: lo schema DB v1 copre già tutti i pannelli fino alla Fase 5.
  Le migrazioni saranno necessarie solo per correzioni, non per nuove feature.
- **SyncService astratto**: passare da offline a cloud richiede una sola nuova classe
  e una riga in `terapia_providers.dart`.
- **Pseudonimizzazione GDPR**: l'anagrafica non lascia il device; il server vede solo
  `paziente_id` + dati clinici.
