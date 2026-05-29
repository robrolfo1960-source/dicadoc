import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'features/monitora/monitora_panel_screen.dart';
import 'features/terapia/terapia_panel_screen.dart';

class DicaDocApp extends StatelessWidget {
  const DicaDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DicaDoc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _HomeScreen(),
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
        ],
      ),
    );
  }
}
