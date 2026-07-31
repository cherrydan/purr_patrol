import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
   


class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  
  int _currentIndex = 0;
  
  final List<Widget> _screens = const [
       Center(child: Text('Map')),
       Center(child: Text('Feed')),
       Center(child: Text('Profile')),
     ];
     

     


  @override
  Widget build(BuildContext context) {
  
  final l10n = AppLocalizations.of(context)!;
   


    return Scaffold(body: _screens[_currentIndex], bottomNavigationBar: BottomNavigationBar(
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