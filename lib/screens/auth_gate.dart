import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purr_patrol/screens/main_tab_screen.dart';
import '../services/auth_service.dart';
import '../screens/login_screen.dart';
class AuthGate extends StatelessWidget{
  const AuthGate({super.key}); 

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    
    return  StreamBuilder<User?>(
        stream: authService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { 
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if(snapshot.hasData) { 
            return MainTabScreen();
          }
          return const LoginScreen();

  });
  }
}