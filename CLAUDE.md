# DicaDoc / PMMC — CLAUDE.md

Suite Flutter per aderenza terapeutica e monitoraggio remoto del paziente cronico.
Due ruoli: **Medico** (macOS) e **Paziente** (iOS/Android).

---

## Architettura

```
lib/
├── main.dart               # Boot: SecureStorage → DB → Seed → NotifService → Sync → runApp
├── app.dart                # Router: Platform.isMacOS → /medico, iOS → /home o /onboarding
├── core/
│   ├── enums.dart          # Enum di dominio (NON riordinare: drift li salva come indice int)
│   └── theme.dart
├── data/
│   ├── config/app_config.dart      # AppConfig: pazienteId, serverUrl (FlutterSecureStorage)
│   ├── db/database.dart            # Schema Drift v1 — non modificare senza migration
│   ├── security/crypto_service.dart
│   ├── seed/seed_data.dart
│   └── sync/
│       ├── sync_service.dart       # Interfaccia + LocalOnlySync (no-op)
│       ├── cloud_sync.dart         # CloudSync → PocketBase REST
│       └── pocketbase_client.dart  # HTTP wrapper minimale
└── features/
    ├── medico/             # SOLO macOS: lista pazienti, scheda, QR
    ├── terapia/            # P1 TERAPIA + F1 ALERT
    ├── monitora/           # P2 MONITORA (misurazioni)
    ├── referti/            # P3 REFERTI (OCR ML Kit)
    ├── anamnesi/           # P4 ANAMNESI
    ├── profilo/            # P5 PROFILO + logout + QR scan
    ├── settings/           # Impostazioni: URL server, ri-registrazione
    ├── onboarding/         # Onboarding QR (prima accensione)
    ├── alert/              # NotificationService (F1)
    └── health/             # HealthConnectService (F6, stub Android)
```

---

## Comandi chiave

```bash
# Analisi statica (deve essere zero errori)
flutter analyze lib/

# macOS (medico) — sviluppo
flutter build macos --debug && open build/macos/Build/Products/Debug/dicadoc.app

# iOS (paziente) — installa su iPhone fisico (richiede ~5 min su iOS 26 beta)
flutter run -d 00008110-001418D01ED9801E --release

# Android
flutter build apk --debug

# PocketBase (backend sync, lanciare prima di testare il sync)
~/pocketbase/pocketbase serve --dir=/tmp/dicadoc_pb
# Admin: http://localhost:8090/_/  credenziali: medico@dicadoc.local / Dicadoc2024!
```

---

## Piattaforme e quirk noti

### macOS (Medico)
- Modalità medico attivata da `Platform.isMacOS` in `app.dart`
- `FlutterSecureStorage`: usa `MacOsOptions(useDataProtectionKeyChain: false)` altrimenti l'avvio si blocca nel sandbox senza entitlement keychain
- `NotificationService.init()`: richiede `macOS: darwinInit` in `InitializationSettings`, altrimenti blocca l'avvio mostrando un dialog permessi
- Sync auto-configurato su `http://localhost:8090` al primo avvio se serverUrl è assente
- Entitlements: `network.client` in Debug+Release per le chiamate HTTP a PocketBase

### iOS (Paziente)
- **SQLCipher bypassato**: `Platform.isIOS → NativeDatabase(file)` senza PRAGMA key — causa schermata bianca in AOT release. iOS protegge già con Data Protection + sandbox.
- **mobile_scanner**: fissato a `^5.2.3` (CocoaPods). v6.x rompe MLKit; v7.x usa SPM non supportato da Flutter su iOS 26 beta.
- **google_mlkit**: fissato a `^0.13.1` / `^0.8.1` (MLKit 6.x compatibile con mobile_scanner v5)
- iOS deployment target: **16.0** (minimo richiesto da mobile_scanner v5)
- Installazione su iPhone fisico: usare `flutter run --release`, NON il tasto Run di Xcode né `xcrun devicectl` (firma Flutter.framework non compatibile)
- Reinstall richiede sempre `flutter run --release` + USB + ~5 min (iOS 26 beta lento)
- Autorizzazione developer: Impostazioni → Generali → VPN e gestione dispositivo → Trust
- Modalità Sviluppatore: Impostazioni → Privacy e Sicurezza → Modalità Sviluppatore

### Android
- `compileSdk = 36`, `minSdk = 26` (Android 8+, richiesto da health package)
- Toolchain: AGP 8.11.1, Kotlin 2.2.20, Gradle 8.14.2
- Patch locale `health` in `packages/health/` (compileSdk 34→36 per Health Connect)

---

## Database (Drift v1)

Schema stabile — aggiungere solo migrazioni, mai modificare le tabelle esistenti.

Tabelle: `Pazienti`, `Patologie`, `RisposteAnamnesi`, `CatalogoParametri`,
`ParametriAbilitati`, `Misurazioni`, `TemplateReferti`, `Terapie`, `OrariTerapia`, `Assunzioni`

Ogni tabella clinica ha `sincronizzato: bool` per il local-first sync.

File DB: `dicadoc_v3.sqlite` (v1/v2 in chiaro ignorati, seed ricrea demo al primo avvio)

---

## Sync (F2)

```
LocalOnlySync  →  nessuna rete (default)
CloudSync      →  PocketBase REST, attivo se AppConfig.serverUrl != null
```

`CloudSync.push()`: invia terapie (medico→server) + misurazioni/assunzioni (paziente→server)  
`CloudSync.pull()`: scarica terapie (server→paziente) + misurazioni (server→medico)

Il `pazienteCorrenteIdProvider` è un `NotifierProvider<PazienteIdNotifier, int>` aggiornabile a runtime: dopo il QR scan il notifier si aggiorna e il pull avviene immediatamente senza riavvio.

---

## Flusso medico → paziente

1. **Medico** crea paziente su macOS → aggiunge terapia → preme Sync (📶)
2. **Medico** apre QR (📲) → imposta URL `http://192.168.1.95:8090` → mostra QR
3. **Paziente** scansiona QR da Profilo o da onboarding
4. App paziente chiama `CloudSync.pull()` → importa terapie
5. Paziente registra misurazioni → push automatico
6. **Medico** preme Sync → vede misurazioni nella scheda paziente

---

## Provider e dipendenze chiave

```dart
appDatabaseProvider          // override in main.dart
notificationServiceProvider  // override in main.dart
appConfigProvider            // override in main.dart
syncServiceProvider          // override in main.dart (LocalOnly o CloudSync)
pazienteCorrenteIdProvider   // NotifierProvider, aggiornabile dopo QR scan
```

---

## Regole di sviluppo

- **Enum**: non riordinare mai le voci esistenti — Drift le salva come indice intero
- **FAB**: ogni FloatingActionButton deve avere `heroTag` univoco (IndexedStack tiene tutti i tab vivi → crash Hero animation)
- **macOS**: testare sempre con `flutter build macos --debug`, non solo `flutter analyze`
- **iOS**: non usare `NativeDatabase.createInBackground()` — crasha in AOT su iOS 26
- **Notifiche macOS**: `InitializationSettings` deve includere `macOS: darwinInit` con tutti i permessi a `false`
- **Providers immutabili**: non usare `overrideWithValue` su `NotifierProvider`
