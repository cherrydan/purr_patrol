
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purr_patrol/l10n/app_localizations.dart';
import 'package:purr_patrol/services/auth_service.dart';
import 'package:purr_patrol/widgets/terms_dialog.dart';


class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; 
    final authService = AuthService();
    String rankTitle = l10n.rankNewbie;
    Color rankColor = Colors.green;
     return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTab)),
      body: StreamBuilder<User?>(
        stream: authService.authStateChanges,
        builder: (context, snapshot) {
          final user = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // 🟢 Карточка профиля
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // 1. Аватарка (из Google или иконка)
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFF2ECC71),
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                        child: user?.photoURL == null
                            ? const Icon(Icons.person_rounded, size: 50, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(height: 12),

                      // 2. Имя волонтера (Из Google или дефолт)
                      Text(
                        user?.displayName ?? l10n.volunteerTitle,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (user?.email != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          user!.email!,
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                      const SizedBox(height: 10),
                      Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: rankColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        rankTitle,
                        style: TextStyle(
                          color: rankColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                      
                      // 3. Кнопка Входа или Выхода
                      if (user == null)
                        ElevatedButton.icon(
                          onPressed: () async {
                            await authService.signInWithGoogle();
                          },
                          icon: const Icon(Icons.login_rounded),
                          label: Text(l10n.signInWithGoogle),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2ECC71),
                            foregroundColor: Colors.white,
                          ),
                        )
                      else
                        OutlinedButton.icon(
                          onPressed: () async {
                            await authService.signOut();
                          },
                          icon: const Icon(Icons.logout_rounded, color: Colors.red),
                          label: Text(
                            l10n.signOutButton,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        if (user != null) 
                        StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
                      builder: (context, userSnap) {
                        int karma = 0;
                        int catsCount = 0;

                        if (userSnap.hasData && userSnap.data!.exists) {
                          final userData = userSnap.data!.data() as Map<String, dynamic>?;
                          karma = userData?['karmaPoints'] ?? 0;
                          if (karma >= 150) {
                            rankTitle = l10n.rankLegend;
                            rankColor = Colors.amber.shade800;
                          } else if (karma >= 50) {
                            rankTitle = l10n.rankGuardian;
                            rankColor = Colors.blue; 
                            }
                           else {
                            rankTitle = l10n.rankNewbie;
                            rankColor = Colors.green;
                          }
                          catsCount = userData?['catsAddedCount'] ?? 0;
                        }

                        // Рендерим плашку со статистикой!
                        return Padding(
  padding: const EdgeInsets.only(top: 16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // 1. Плашка Кармы 🌟
      Column(
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 28),
          const SizedBox(height: 4),
          Text(
            '$karma',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            l10n.karmaTitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),

      // Разделитель
      Container(height: 30, width: 1, color: Colors.grey.shade300),

      // 2. Плашка Котиков 🐱
      Column(
        children: [
          const Icon(Icons.pets_rounded, color: Color(0xFF2ECC71), size: 28),
          const SizedBox(height: 4),
          Text(
            '$catsCount',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            l10n.catsAddedTitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ],
  ),
);

                      },
                    )

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
],
          );
        },
      ),
    );
  }
}