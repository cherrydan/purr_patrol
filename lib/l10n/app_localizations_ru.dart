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
}
