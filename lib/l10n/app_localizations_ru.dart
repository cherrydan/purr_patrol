// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'PurrPatrol: Кот-Локатор 🐾';

  @override
  String get mapTab => 'Карта';

  @override
  String get feedTab => 'SOS Лента';

  @override
  String get profileTab => 'Профиль';

  @override
  String get catStatusHealthy => 'Здоров';

  @override
  String get catStatusDangerDogs => '⚠️ Опасность (Собаки)';

  @override
  String get catStatusLostPet => '🔍 Потеряшка';

  @override
  String get photoUnavailable => 'Фото пока отсутствует';

  @override
  String get helpTheCatButton => 'Помочь котику';

  @override
  String get microchipped => 'Чипирован 🔖';

  @override
  String get sterilized => 'Стерилизован ✂️';

  @override
  String get addCatMarker => 'Добавить котика';

  @override
  String get addCatTitle => 'Новая метка котика 🐾';

  @override
  String get catTitleInput => 'Название (например: Пушок у пекарни)';

  @override
  String get catDescriptionInput => 'Описание и приметы';

  @override
  String get saveCatButton => 'Сохранить метку';

  @override
  String get catLatCoord => 'Широта';

  @override
  String get catLongCoord => 'Долгота';

  @override
  String get enterPrompt => 'Пожалуйста, введите число';

  @override
  String get valueError => 'Некоректный формат числа';

  @override
  String get latRangeError => 'Диапазон для широты: -90.0 до 90.0';

  @override
  String get longRangeError => 'Диапазон для долготы: -180.0 до 180.0';
}
