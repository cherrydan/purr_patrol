// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PurrPatrol: Cat Locator 🐾';

  @override
  String get mapTab => 'Map';

  @override
  String get feedTab => 'SOS Feed';

  @override
  String get profileTab => 'Profile';

  @override
  String get catStatusHealthy => 'Healthy';

  @override
  String get catStatusDangerDogs => '⚠️ Danger (Dogs)';

  @override
  String get catStatusLostPet => '🔍 Lost Pet';

  @override
  String get photoUnavailable => 'Photo unavailable';

  @override
  String get helpTheCatButton => 'Help the cat';

  @override
  String get microchipped => 'Microchipped 🔖';

  @override
  String get sterilized => 'Sterilized ✂️';
}
