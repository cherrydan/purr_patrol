import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'PurrPatrol: Cat Locator 🐾'**
  String get appTitle;

  /// No description provided for @mapTab.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapTab;

  /// No description provided for @feedTab.
  ///
  /// In en, this message translates to:
  /// **'SOS Feed'**
  String get feedTab;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// No description provided for @catStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Cat Status'**
  String get catStatusLabel;

  /// No description provided for @catStatusInjured.
  ///
  /// In en, this message translates to:
  /// **'Injured'**
  String get catStatusInjured;

  /// No description provided for @catStatusNeedsFood.
  ///
  /// In en, this message translates to:
  /// **'Needs Food or Water'**
  String get catStatusNeedsFood;

  /// No description provided for @catStatusHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get catStatusHealthy;

  /// No description provided for @catStatusDangerDogs.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Danger (Dogs)'**
  String get catStatusDangerDogs;

  /// No description provided for @catStatusLostPet.
  ///
  /// In en, this message translates to:
  /// **'🔍 Lost Pet'**
  String get catStatusLostPet;

  /// No description provided for @photoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Photo unavailable'**
  String get photoUnavailable;

  /// No description provided for @helpTheCatButton.
  ///
  /// In en, this message translates to:
  /// **'Help the cat'**
  String get helpTheCatButton;

  /// No description provided for @microchipped.
  ///
  /// In en, this message translates to:
  /// **'Microchipped 🔖'**
  String get microchipped;

  /// No description provided for @sterilized.
  ///
  /// In en, this message translates to:
  /// **'Sterilized ✂️'**
  String get sterilized;

  /// No description provided for @addCatMarker.
  ///
  /// In en, this message translates to:
  /// **'Add Cat'**
  String get addCatMarker;

  /// No description provided for @addCatTitle.
  ///
  /// In en, this message translates to:
  /// **'New Cat Marker 🐾'**
  String get addCatTitle;

  /// No description provided for @catTitleInput.
  ///
  /// In en, this message translates to:
  /// **'Title (e.g., Fluffy by the bakery)'**
  String get catTitleInput;

  /// No description provided for @catDescriptionInput.
  ///
  /// In en, this message translates to:
  /// **'Description & traits'**
  String get catDescriptionInput;

  /// No description provided for @saveCatButton.
  ///
  /// In en, this message translates to:
  /// **'Save Marker'**
  String get saveCatButton;

  /// No description provided for @catLatCoord.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get catLatCoord;

  /// No description provided for @catLongCoord.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get catLongCoord;

  /// No description provided for @enterPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please, enter a value'**
  String get enterPrompt;

  /// No description provided for @valueError.
  ///
  /// In en, this message translates to:
  /// **'Incorrect number format'**
  String get valueError;

  /// No description provided for @latRangeError.
  ///
  /// In en, this message translates to:
  /// **'Latitude range from -90.0 to 90.0'**
  String get latRangeError;

  /// No description provided for @longRangeError.
  ///
  /// In en, this message translates to:
  /// **'Longitude range from -180.0 to 180.0'**
  String get longRangeError;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Cat gender:'**
  String get genderLabel;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male ♂️'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female ♀️'**
  String get genderFemale;

  /// No description provided for @genderUnknown.
  ///
  /// In en, this message translates to:
  /// **'❓'**
  String get genderUnknown;

  /// No description provided for @riskLabel.
  ///
  /// In en, this message translates to:
  /// **'Risk level'**
  String get riskLabel;

  /// No description provided for @riskSafe.
  ///
  /// In en, this message translates to:
  /// **'Safe 🟢'**
  String get riskSafe;

  /// No description provided for @riskDogsNearby.
  ///
  /// In en, this message translates to:
  /// **'Dogs nearby 🟡'**
  String get riskDogsNearby;

  /// No description provided for @riskUrgentDanger.
  ///
  /// In en, this message translates to:
  /// **'URGENT DANGER 🔴'**
  String get riskUrgentDanger;

  /// No description provided for @cameraButton.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraButton;

  /// No description provided for @galleryButton.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryButton;

  /// No description provided for @addedOn.
  ///
  /// In en, this message translates to:
  /// **'Added on:'**
  String get addedOn;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All🐾'**
  String get filterAll;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'PurrPatrol Community Rules 🐾'**
  String get termsTitle;

  /// No description provided for @termsBody.
  ///
  /// In en, this message translates to:
  /// **'By using this application, you agree to use cat location data exclusively for their protection, feeding, medical care, and rehoming. Any use of this data to harm animals or using location data for OTHER purposes is strictly prohibited and subject to legal action.'**
  String get termsBody;

  /// No description provided for @termsAcceptButton.
  ///
  /// In en, this message translates to:
  /// **'I pledge to protect cats'**
  String get termsAcceptButton;

  /// No description provided for @volunteerPage.
  ///
  /// In en, this message translates to:
  /// **'Volunteer\'s Profile'**
  String get volunteerPage;

  /// No description provided for @volunteerTitle.
  ///
  /// In en, this message translates to:
  /// **'PurrPatrol Volunteer'**
  String get volunteerTitle;

  /// No description provided for @activeRescuerBadge.
  ///
  /// In en, this message translates to:
  /// **'Active Cat Rescuer 🛡️'**
  String get activeRescuerBadge;

  /// No description provided for @communityRulesButton.
  ///
  /// In en, this message translates to:
  /// **'Community Rules 📜'**
  String get communityRulesButton;

  /// No description provided for @appVersionInfo.
  ///
  /// In en, this message translates to:
  /// **'App Version 1.0.0 🐾'**
  String get appVersionInfo;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'PurrPatrol — Emergency Cat Network'**
  String get appTagline;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google 🔑'**
  String get signInWithGoogle;

  /// No description provided for @signOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Out 🚪'**
  String get signOutButton;

  /// No description provided for @karmaTitle.
  ///
  /// In en, this message translates to:
  /// **'Volunteer Karma'**
  String get karmaTitle;

  /// No description provided for @catsAddedTitle.
  ///
  /// In en, this message translates to:
  /// **'Cats on Map'**
  String get catsAddedTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
