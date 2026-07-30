import 'package:flutter/material.dart';
import 'package:quick_pdf/core/theme/app_theme.dart';

void main() {
  runApp(const QuickPdfApp());
}

class QuickPdfApp extends StatelessWidget {
  const QuickPdfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick PDF',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const Scaffold(),
    );
  }
}
