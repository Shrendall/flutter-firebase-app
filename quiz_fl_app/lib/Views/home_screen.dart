import 'package:flutter/material.dart';
import 'package:quiz_fl_app/l10n/app_localizations.dart';
import 'main_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    MainScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final List<String> titles = [
      loc.passwordGenerator,
      loc.passwordHistory,
      loc.settings,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(titles[_selectedIndex])),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.lock),
            label: loc.passwordGenerator,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: loc.passwordHistory,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: loc.settings,
          ),
        ],
      ),
    );
  }
}
