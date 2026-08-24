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
  String get catStatusLabel => 'Estado de gatito';

  @override
  String get catStatusInjured => 'Traumatizado';

  @override
  String get catStatusNeedsFood => 'Necesita comida o agua';

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

  @override
  String get addCatMarker => 'Añadir gato';

  @override
  String get addCatTitle => 'Nueva marca de gato 🐾';

  @override
  String get catTitleInput => 'Título (ej.: Pelusa en la panadería)';

  @override
  String get catDescriptionInput => 'Descripción y rasgos';

  @override
  String get saveCatButton => 'Guardar marca';

  @override
  String get catLatCoord => 'Latitud';

  @override
  String get catLongCoord => 'Longitud';

  @override
  String get enterPrompt => 'Por favor, introduzca un número';

  @override
  String get valueError => 'Formato de número no válido';

  @override
  String get latRangeError => 'Rango de latitud de -90.0 a 90.0';

  @override
  String get longRangeError => 'Rango de longitud de -180.0 a 180.0';

  @override
  String get genderLabel => 'El género del gatito';

  @override
  String get genderMale => 'Macho ♂️';

  @override
  String get genderFemale => 'Hembra ♀️';

  @override
  String get genderUnknown => '❓';

  @override
  String get riskLabel => 'Nivel de riesgo';

  @override
  String get riskSafe => 'Seguro 🟢';

  @override
  String get riskDogsNearby => 'Hay perros cerca 🟡';

  @override
  String get riskUrgentDanger => 'PELIGRO URGENTE 🔴';

  @override
  String get cameraButton => 'Cámara';

  @override
  String get galleryButton => 'Galería';

  @override
  String get addedOn => 'Añadido:';

  @override
  String get filterAll => 'Todo🐾';

  @override
  String get termsTitle => 'Reglas de la comunidad PurrPatrol 🐾';

  @override
  String get termsBody =>
      'Al usar esta aplicación, te comprometes a utilizar los datos de ubicación de los gatos exclusivamente para su protección, alimentación, atención médica y adopción. Queda estrictamente prohibido cualquier uso de los datos para dañar a los animales o el uso de datos de ubicación con OTROS fines.';

  @override
  String get termsAcceptButton => 'Me comprometo a proteger a los gatos';
}
