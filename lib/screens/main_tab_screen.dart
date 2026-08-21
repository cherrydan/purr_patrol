import 'package:flutter/material.dart';
import 'package:purr_patrol/models/cat_marker.dart';
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