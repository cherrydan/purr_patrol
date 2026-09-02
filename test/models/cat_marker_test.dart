import 'package:flutter_test/flutter_test.dart';
import 'package:purr_patrol/models/cat_enums.dart';
import 'package:purr_patrol/models/cat_marker.dart';

void main() {
  group('CatMarker Model Tests', () {
    test('should correctly convert CatMarker to Map and back from Map', () {
      // 1. Создаем тестового котика
      final now = DateTime.now();
      final originalCat = CatMarker(
        id: 'test_123',
        latitude: 40.416775,
        longitude: -3.703790,
        title: 'Тестовый Мурзик',
        description: 'Описание тестового котика',
        imageUrl: 'https://example.com/cat.jpg',
        status: CatStatus.injured,
        riskLevel: RiskLevel.urgentDanger,
        gender: CatGender.male,
        isChipped: true,
        isSterilized: true,
        authorId: 'user_456',
        createdAt: now,
      );

      // 2. Конвертируем в Map
      final catMap = originalCat.toMap();

      // 3. Восстанавливаем из Map
      final restoredCat = CatMarker.fromMap(catMap);

      // 4. Проверяем равенство полей!
      // (Напиши проверки expect для title, status, gender, riskLevel, isChipped и т.д.)
      expect(restoredCat.id, originalCat.id);
      expect(restoredCat.latitude, originalCat.latitude);
      expect(restoredCat.longitude, originalCat.longitude);
      expect(restoredCat.title, originalCat.title);
      expect(restoredCat.description, originalCat.description);
      expect(restoredCat.imageUrl, originalCat.imageUrl);
      expect(restoredCat.status, originalCat.status);
      expect(restoredCat.riskLevel, originalCat.riskLevel);
      expect(restoredCat.gender, originalCat.gender);
      expect(restoredCat.isChipped, originalCat.isChipped);
      expect(restoredCat.isSterilized, originalCat.isSterilized);
      expect(restoredCat.authorId, originalCat.authorId);
      expect(restoredCat.createdAt, originalCat.createdAt);
    });
  });
}
