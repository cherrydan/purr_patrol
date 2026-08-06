// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PurrPatrol: Localizador de Gatos 🐾';

  @override
  String get mapTab => 'Mapa';

  @override
  String get feedTab => 'Feed SOS';

  @override
  String get profileTab => 'Perfil';

  @override
  String get catStatusHealthy => 'Sano';

  @override
  String get catStatusDangerDogs => '⚠️ Peligro (Perros)';

  @override
  String get catStatusLostPet => '🔍 Mascota Perdida';

  @override
  String get photoUnavailable => 'Foto no disponible';

  @override
  String get helpTheCatButton => 'Ayudar al gato';

  @override
  String get microchipped => 'Con microchip 🔖';

  @override
  String get sterilized => 'Esterilizado ✂️';
}
