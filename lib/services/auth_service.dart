import '../services/app_logger.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

    Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Сначала запускаем окно выбора аккаунта
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      // 2. Если закрыл окно — сразу выходим!
      if (googleUser == null) return null;

      // 3. Достаем токены только если пользователь выкатил аккаунт!
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Входим в Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      logger.i("Волонтер вошел через Google: ${userCredential.user?.displayName}");
      return userCredential;
    } catch (e) {
      logger.e("Ошибка входа Google: $e");
      return null;
    }
  }


  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    logger.i("Волонтер вышел из системы");
   }
   

}