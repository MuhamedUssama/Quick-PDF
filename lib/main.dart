import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quick_pdf/core/service_locator/service_locator.dart';
import 'package:quick_pdf/core/services/shared_preferences_services.dart';
import 'package:quick_pdf/core/theme/app_theme.dart';
import 'package:quick_pdf/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferencesServices.init();
  configureDependencies();
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
