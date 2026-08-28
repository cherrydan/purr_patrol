import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/app_logger.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth;
  
  final GoogleSignIn _googleSignIn;

  final FirebaseFirestore _firestore;

  AuthService({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn, FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
         _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> _createOrUpdateUserProfile(User user) async {

    final userRef = _firestore.collection('users').doc(user.uid);
     final doc = await userRef.get();

    if (!doc.exists) {
      // Создаем нового волонтера
      await userRef.set({
        'uid': user.uid,
        'displayName': user.displayName ?? 'Волонтер',
        'email': user.email ?? '',
        'photoUrl': user.photoURL,
        'karmaPoints': 0, 
        'catsAddedCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Обновляем существующего
      await userRef.update({
        'displayName': user.displayName ?? 'Волонтер',
        'photoUrl': user.photoURL,
      });
    }
  }

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
      if (userCredential.user != null) {
        await _createOrUpdateUserProfile(userCredential.user!);
      }
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