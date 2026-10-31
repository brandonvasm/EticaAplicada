import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'home_screen.dart';
import 'situation_screen.dart';
import 'institutions_screen.dart';
import 'help_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Se define la lista dentro del build para responder inmediatamente a cambios de estado o Locale
    final List<Widget> screens = [
      HomeScreen(
        onNavigateToServices: () => _changeTab(1), // Cambia a la pestaña 'Servicios'
      ),
      const SituationScreen(),
      const InstitutionsScreen(),
      const HelpScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF0D5C58),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _changeTab,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_outlined),
            activeIcon: const Icon(Icons.search),
            label: l10n.navServices,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.business_outlined),
            activeIcon: const Icon(Icons.business),
            label: l10n.navInstitutions,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.help_outline),
            activeIcon: const Icon(Icons.help),
            label: l10n.navHelp,
          ),
        ],
      ),
    );
  }
}