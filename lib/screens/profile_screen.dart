
import 'package:flutter/material.dart';
import 'package:purr_patrol/l10n/app_localizations.dart';
import 'package:purr_patrol/widgets/terms_dialog.dart';


class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; 
    return Scaffold(appBar: AppBar(title: Text(l10n.profileTab)), body: 
    // оберни Card в ListView 
    ListView( padding: const EdgeInsets.all(16.0), children: [
    Card(
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        // 1. Аватарка
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFF2ECC71),
          child: Icon(Icons.person_rounded, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 12),

        // 2. Имя волонтера
        Text(
          l10n.volunteerTitle, // Позже свяжем с Firebase Auth!
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),

        // 3. Бейджик статуса "Активный спасатель 🛡️"
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            l10n.activeRescuerBadge,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    ),
  ),
),
          const SizedBox(height: 16),

          // Menu items
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // 1. Community Rules button
                ListTile(
                  leading: const Icon(Icons.verified_user_rounded, color: Color(0xFF2ECC71)),
                  title: Text(l10n.communityRulesButton),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => showTermsDialog(context),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),

                // 2. App Version info
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded, color: Colors.grey),
                  title: Text(l10n.appVersionInfo),
                  subtitle: Text(l10n.appTagline),
                ),
              ],
            ),
          ),

]), 
    );
  }
}