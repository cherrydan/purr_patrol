import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

void showTermsDialog(BuildContext context, {bool isFirstLaunch = false, SharedPreferences? prefs}) {
  final l10n = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    barrierDismissible: !isFirstLaunch, // При первом запуске кликнуть мимо нельзя!
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(l10n.termsTitle),
      content: Text(l10n.termsBody),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (prefs != null) {
              await prefs.setBool('terms_accepted', true);
            }
            if (!context.mounted) return;
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2ECC71),
            foregroundColor: Colors.white,
          ),
          child: Text(l10n.termsAcceptButton),
        ),
      ],
    ),
  );
}
