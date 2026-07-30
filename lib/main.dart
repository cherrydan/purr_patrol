import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // Наш сгенерированный класс

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PurrPatrolApp());
}

class PurrPatrolApp extends StatelessWidget {
  const PurrPatrolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PurrPatrol',
      debugShowCheckedModeBanner: false,
      
      // 🟢 НАСТРОЙКА ЛОКАЛИЗАЦИИ:
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('ru'), // Russian
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2ECC71),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return Text(
                l10n.appTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
      ),
    );
  }
}
