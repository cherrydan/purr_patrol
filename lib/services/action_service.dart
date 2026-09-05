import 'package:purr_patrol/l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/cat_marker.dart';
import 'app_logger.dart';

class ActionService {
  // 1. 📍 Открыть навигатором (Google Maps / OpenStreetMap)
    // 1. 📍 Открыть навигатором (Google Maps / Yandex / OpenStreetMap)
  static Future<void> openMapDirections(double lat, double lng) async {
    final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    try {
      // 🟢 Запускаем навигатор напрямую!
      final bool launched = await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        logger.e("Не удалось запустить приложение карт для: $lat, $lng");
      }
    } catch (e) {
      logger.e("Ошибка при запуске навигатора: $e");
    }
  }

  // 2. 📲 Поделиться карточкой котика в Telegram / WhatsApp
    // 2. 📲 Поделиться карточкой котика (Локализованно!)
  static Future<void> shareCatInfo(CatMarker cat, AppLocalizations l10n) async {
    final String shareText = '''
${l10n.shareHeader}

${l10n.shareTitleLabel}: ${cat.title}
${l10n.shareDescriptionLabel}: ${cat.description}
${l10n.shareCoordsLabel}: ${cat.latitude}, ${cat.longitude}

${l10n.shareOpenMapsLabel}: https://www.google.com/maps/search/?api=1&query=${cat.latitude},${cat.longitude}
''';

    try {
      await SharePlus.instance.share(ShareParams(text: shareText));
    } catch (e) {
      logger.e("Ошибка при отправке карточки котика: $e");
    }
  }

}
