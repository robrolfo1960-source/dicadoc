# DicaDoc / PMMC — Fase 1 (F1 ALERT + P1 TERAPIA)

Prototipo Flutter dell'app paziente. In questa fase: promemoria terapia con
rilancio dell'allarme per i salvavita, pannello terapia con emoticon
verde/rossa e registrazione dell'assunzione (Assunto / Posticipa 15 min /
Rifiutato). Tutto **offline**, ma con il layer di sincronizzazione gia'
predisposto per il cloud (vedi `lib/data/sync/sync_service.dart`).

---

## Cosa contiene questo pacchetto

- `lib/` — tutto il codice Dart dell'app
- `pubspec.yaml` — le dipendenze
- `android_config/` — gli snippet da incollare nella configurazione Android

NON contiene la cartella di progetto Flutter completa (android/, ios/, ecc.):
quella la genera Android Studio. I passi sotto spiegano come unire le due cose.

---

## Setup in Android Studio (passo per passo)

### 1. Crea un nuovo progetto Flutter
In Android Studio: **File ▸ New ▸ New Flutter Project ▸ Flutter**.
- Nome progetto: `dicadoc`
- Platforms: lascia almeno **Android** selezionato
- Premi Create.

Questo genera lo scheletro (cartelle `android/`, `lib/`, ecc.).

### 2. Sostituisci i file generati con quelli del pacchetto
- **Cancella** la cartella `lib/` creata da Android Studio e **copia** al suo
  posto la `lib/` di questo pacchetto.
- **Sostituisci** il `pubspec.yaml` del progetto con quello del pacchetto
  (oppure incolla le dipendenze nella sezione `dependencies` / `dev_dependencies`).

### 3. Configura Android per le notifiche
Apri `android/app/src/main/AndroidManifest.xml` e inserisci i permessi e i
receiver indicati in `android_config/AndroidManifest_snippet.xml`
(i permessi prima di `<application>`, i receiver dentro `<application>`).

Apri `android/app/build.gradle` (o `build.gradle.kts`) e applica le modifiche
di `android_config/build_gradle_notes.md`:
- abilita il **core library desugaring**
- imposta **minSdk = 23**

> Senza il desugaring la build Android fallisce: e' il punto che dimentica
> quasi tutti la prima volta.

### 4. Scarica le dipendenze
Nel terminale di Android Studio (tab "Terminal" in basso):
```
flutter pub get
```
Se segnala conflitti di versione, prova:
```
flutter pub upgrade --major-versions
```

### 5. Genera il codice del database (drift)
Il database usa la generazione di codice: serve creare `database.g.dart`.
Finche' non lo fai, l'editor mostrera' errori rossi su `database.dart`: e'
NORMALE prima di questo passo.
```
dart run build_runner build --delete-conflicting-outputs
```
(Per rigenerare automaticamente mentre sviluppi:
`dart run build_runner watch --delete-conflicting-outputs`)

### 6. Avvia l'app
Collega un telefono (con debug USB) oppure avvia un emulatore Android 13+
(consigliato, per provare il permesso notifiche). Poi premi **Run ▶** o:
```
flutter run
```

Al primo avvio l'app chiede il permesso notifiche e crea un paziente di
esempio con due terapie. Tocca i "chip" degli orari per registrare l'assunzione.

---

## Come provare gli ALERT (F1)

I promemoria sono pianificati agli orari delle terapie (08:00 / 13:00 / 20:00
nei dati di esempio). Per vederli subito senza aspettare, la via piu' rapida e'
modificare temporaneamente un orario nel seed (`lib/data/seed/seed_data.dart`)
a pochi minuti dall'ora attuale, disinstallare l'app (per ri-eseguire il seed)
e riavviare. Su Android 12+ il permesso "Sveglie e promemoria" puo' richiedere
conferma manuale nelle impostazioni di sistema.

---

## Struttura del codice

```
lib/
├── main.dart                       avvio: DB, seed, notifiche, Riverpod
├── app.dart                        MaterialApp + tema
├── core/
│   ├── enums.dart                  enum di dominio (priorita, stati, ...)
│   └── theme.dart                  tema e colori semaforo
├── data/
│   ├── db/database.dart            SCHEMA COMPLETO (drift) + connessione
│   ├── seed/seed_data.dart         dati di esempio
│   └── sync/sync_service.dart      astrazione sync (locale ora, cloud poi)
└── features/
    ├── alert/notification_service.dart   F1: ALERT + escalation
    └── terapia/
        ├── terapia_repository.dart       logica dosi/assunzioni
        ├── terapia_providers.dart        provider Riverpod
        ├── terapia_panel_screen.dart     P1: TERAPIA (schermata principale)
        └── widgets/                      card farmaco + foglio azioni
```

Lo schema DB e' gia' completo (Catalogo Parametri, Misurazioni, Template
Referto, Pazienti, Patologie, Terapie, Orari, Assunzioni): le Fasi 2-5
aggiungono solo schermate, non toccano l'impianto.

---

## Verso il cloud (quando vorrai, anche gratis)

Quando passeremo all'obiettivo "cloud-first" bastera':
1. creare una classe `CloudSync implements SyncService` (traccia gia' nel file
   `sync_service.dart`);
2. cambiare una riga in `terapia_providers.dart` (`syncServiceProvider`).

Backend gratuiti adatti a dati sanitari in UE: VPS Oracle "Always Free" (anche
regione Milano) con sopra PocketBase, oppure Supabase free tier in regione UE.
Nessuna modifica a UI o schema.
