import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:purr_patrol/screens/auth_gate.dart';
import 'l10n/app_localizations.dart'; // Наш сгенерированный класс
import 'package:firebase_core/firebase_core.dart';
   


void main() async {
  // 🟢 Обязательная инициализация связок Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 🟢 Инициализируем Firebase для Android/iOS
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );

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
      home: const AuthGate(),
    );
  }
}
