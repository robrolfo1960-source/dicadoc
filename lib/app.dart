import 'dart:io';

import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'features/medico/medico_home_screen.dart';
import 'features/monitora/monitora_panel_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/profilo/profilo_screen.dart';
import 'features/referti/referti_panel_screen.dart';
import 'features/terapia/terapia_panel_screen.dart';

class DicaDocApp extends StatelessWidget {
  const DicaDocApp({super.key, required this.showOnboarding});

  final bool showOnboarding;

  // macOS = modalità medico; iOS/Android = modalità paziente.
  static bool get isMedico => Platform.isMacOS;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: isMedico ? 'DicaDoc Medico' : 'DicaDoc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: isMedico
          ? '/medico'
          : (showOnboarding ? '/onboarding' : '/home'),
      routes: {
        '/medico': (_) => const MedicoHomeScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/home': (_) => const _HomeScreen(),
      },
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen();

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: const [
          TerapiaPanelScreen(),
          MonitoraPanelScreen(),
          RefertiPanelScreen(),
          ProfiloScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.medication_outlined),
            selectedIcon: Icon(Icons.medication),
            label: 'Terapia',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_heart_outlined),
            selectedIcon: Icon(Icons.monitor_heart),
            label: 'Monitora',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Referti',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}
