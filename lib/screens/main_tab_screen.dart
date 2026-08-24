import 'package:flutter/material.dart';
import 'package:purr_patrol/models/cat_marker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import 'map_screen.dart';
import 'feed_screen.dart';
   

   
   


class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  
  int _currentIndex = 0;
  CatMarker? _targetCatForMap; // 🟢 Котик, к которому нужно подлететь на карте


  @override
   void initState() {
     super.initState();
     _checkTermsConsent();
   }
   

   

Future<void> _checkTermsConsent() async {
  final prefs = await SharedPreferences.getInstance();
  
  bool accepted = prefs.getBool('terms_accepted') ?? false;

  if (!accepted && mounted) {
    _showsTermsDialog(prefs);
  }
}
     
void _showsTermsDialog(SharedPreferences prefs) {

  final l10n = AppLocalizations.of(context)!;

  showDialog(context: context, 
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Text(l10n.termsTitle), 
    content: Text(l10n.termsBody),
    actions: [
      ElevatedButton(onPressed: () async {
        await prefs.setBool('terms_accepted', true);
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


  @override
  Widget build(BuildContext context) {
  
  final l10n = AppLocalizations.of(context)!;

  final List<Widget> screens = [
      MapScreen(targetCat: _targetCatForMap), // Передаем котика в MapScreen
      FeedScreen(
        onCatSelected: (cat) {
          setState(() {
            _currentIndex = 0;      // Switch to Map tab
            _targetCatForMap = cat; // Remember the target cat
          });
        },
      ),
      const Center(child: Text('Profile')),
    ]; 


  return Scaffold(body: screens[_currentIndex], bottomNavigationBar: BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.map_rounded),
      label: l10n.mapTab,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.campaign_rounded),
      label: l10n.feedTab,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: l10n.profileTab,
    ),
  ],
),
);
}
}
 