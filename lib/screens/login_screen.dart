import 'package:flutter/material.dart';
import 'package:purr_patrol/l10n/app_localizations.dart';
import 'package:purr_patrol/services/auth_service.dart';

class LoginScreen  extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;
   // Иерархия виджетов внутри build:
return Scaffold(
  body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. Иконка-логотип котика
          const Icon(
            Icons.pets_rounded,
            size: 100,
            color: Color(0xFF2ECC71), // Наш фирменный эко-зеленый
          ),
          const SizedBox(height: 16),

          // 2. Заголовок "PurrPatrol"
          const Text(
            'PurrPatrol',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // 3. Слоган из локализации (l10n.appTagline)
          Text(
            l10n.appTagline,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 48),

          // 4. Кнопка "Войти через Google" (ElevatedButton.icon)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await AuthService().signInWithGoogle();
              },
              icon: const Icon(Icons.login_rounded),
              label: Text(l10n.signInWithGoogle),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);

  }
  
}