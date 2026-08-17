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
  String get catStatusLabel => 'Cat Status';

  @override
  String get catStatusInjured => 'Injured';

  @override
  String get catStatusNeedsFood => 'Needs Food or Water';

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

  @override
  String get addCatMarker => 'Add Cat';

  @override
  String get addCatTitle => 'New Cat Marker 🐾';

  @override
  String get catTitleInput => 'Title (e.g., Fluffy by the bakery)';

  @override
  String get catDescriptionInput => 'Description & traits';

  @override
  String get saveCatButton => 'Save Marker';

  @override
  String get catLatCoord => 'Latitude';

  @override
  String get catLongCoord => 'Longitude';

  @override
  String get enterPrompt => 'Please, enter a value';

  @override
  String get valueError => 'Incorrect number format';

  @override
  String get latRangeError => 'Latitude range from -90.0 to 90.0';

  @override
  String get longRangeError => 'Longitude range from -180.0 to 180.0';

  @override
  String get genderLabel => 'Cat gender:';

  @override
  String get genderMale => 'Male ♂️';

  @override
  String get genderFemale => 'Female ♀️';

  @override
  String get genderUnknown => '❓';

  @override
  String get riskLabel => 'Risk level';

  @override
  String get riskSafe => 'Safe 🟢';

  @override
  String get riskDogsNearby => 'Dogs nearby 🟡';

  @override
  String get riskUrgentDanger => 'URGENT DANGER 🔴';

  @override
  String get cameraButton => 'Camera';

  @override
  String get galleryButton => 'Gallery';

  @override
  String get addedOn => 'Added on:';
}
