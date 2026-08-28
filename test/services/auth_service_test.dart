import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:purr_patrol/services/auth_service.dart';

// 🟢 1. Мокаем классы Firebase и Google Sign-In
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}
class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}
   // 🟢 Мокаем AuthCredential
class FakeAuthCredential extends Fake implements AuthCredential {}
   

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // 🟢 Запускаем тестовую среду Flutter

  setUpAll(() {
       registerFallbackValue(FakeAuthCredential());
     });

  // 🟢 2. Объявляем переменные для моков
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthService authService;

  // 🟢 3. Сбрасываем моки перед каждым тестом
  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    
     authService = AuthService(
      auth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );});

  // 🟢 5. Напишем наш первый тестовый кейс!
  group('AuthService', () {
        test('signInWithGoogle success flow', () async {
      // 1. Создаем моки для ответов Google
      final mockGoogleAccount = MockGoogleSignInAccount();
      final mockGoogleAuth = MockGoogleSignInAuthentication();
      final mockUserCredential = MockUserCredential();

      // 2. Настраиваем поведение моков (что они должны возвращать при вызове)
      when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleAccount);
      when(() => mockGoogleAccount.authentication).thenAnswer((_) async => mockGoogleAuth);
      when(() => mockGoogleAuth.accessToken).thenReturn('fake_token');
      when(() => mockGoogleAuth.idToken).thenReturn('fake_id_token');
      
      // Настраиваем Firebase auth на вход с любыми credentials
      // (так как GoogleAuthProvider.credential создает объект, мы можем использовать any())
      when(() => mockFirebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => mockUserCredential);

      // 3. Вызываем тестируемый метод нашего сервиса
      final result = await authService.signInWithGoogle();

      // 4. Проверяем (assert), что всё прошло успешно и вернулся наш мок-результат
      expect(result, equals(mockUserCredential));
      
      // Проверяем, что методы реально вызывались
      verify(() => mockGoogleSignIn.signIn()).called(1);
    });

  });
}
