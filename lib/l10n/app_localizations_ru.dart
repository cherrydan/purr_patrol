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
  String get catStatusLabel => 'Состояние котика';

  @override
  String get catStatusInjured => 'Травмирован';

  @override
  String get catStatusNeedsFood => 'Нужна пища или вода';

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

  @override
  String get genderLabel => 'Пол котика:';

  @override
  String get genderMale => 'Мальчик ♂️';

  @override
  String get genderFemale => 'Девочка ♀️';

  @override
  String get genderUnknown => '❓';

  @override
  String get riskLabel => 'Уровень риска';

  @override
  String get riskSafe => 'Безопасно 🟢';

  @override
  String get riskDogsNearby => 'Рядом собаки 🟡';

  @override
  String get riskUrgentDanger => 'СРОЧНАЯ ОПАСНОСТЬ 🔴';

  @override
  String get cameraButton => 'Камера';

  @override
  String get galleryButton => 'Галерея';

  @override
  String get addedOn => 'Добавлено: ';

  @override
  String get filterAll => 'Все🐾';

  @override
  String get termsTitle => 'Правила сообщества PurrPatrol 🐾';

  @override
  String get termsBody =>
      'Используя приложение, вы обязуетесь использовать геоданные котиков исключительно для их защиты, кормления, лечения и поиска хозяев. Любое использование данных во вред животным или использование геоданных с ДРУГИМИ целями строго запрещено и преследуется по закону.';

  @override
  String get termsAcceptButton => 'Я обязуюсь защищать котиков';

  @override
  String get volunteerPage => 'Профиль волонтёра';

  @override
  String get volunteerTitle => 'Волонтер PurrPatrol';

  @override
  String get activeRescuerBadge => 'Активный спасатель котиков 🛡️';

  @override
  String get communityRulesButton => 'Правила сообщества 📜';

  @override
  String get appVersionInfo => 'Версия приложения 1.0.0 🐾';

  @override
  String get appTagline => 'PurrPatrol — Сеть спасения котиков';

  @override
  String get signInWithGoogle => 'Войти через Google 🔑';

  @override
  String get signOutButton => 'Выйти из аккаунта 🚪';

  @override
  String get karmaTitle => 'Карма волонтера';

  @override
  String get catsAddedTitle => 'Котиков на карте';

  @override
  String get rankNewbie => 'Начинающий друг 🐾';

  @override
  String get rankGuardian => 'Хранитель Города 🛡️';

  @override
  String get rankLegend => 'Легендарный Спасатель 👑';

  @override
  String get catStatusRescued => 'Спасен / Нашел дом 🏠🎉';

  @override
  String get markAsRescuedButton => 'Отметить как спасенного (+50 🌟)';

  @override
  String get openDirections => 'Проложить маршрут 📍';

  @override
  String get shareCat => 'Поделиться 📲';

  @override
  String get shareHeader => '🐾 PurrPatrol: Котику нужна помощь!';

  @override
  String get shareTitleLabel => '📌 Название';

  @override
  String get shareDescriptionLabel => '📝 Описание';

  @override
  String get shareCoordsLabel => '📍 Координаты';

  @override
  String get shareOpenMapsLabel => 'Открыть в Google Maps';
}
