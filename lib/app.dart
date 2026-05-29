import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'features/terapia/terapia_panel_screen.dart';

class DicaDocApp extends StatelessWidget {
  const DicaDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DicaDoc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const TerapiaPanelScreen(),
    );
  }
}
