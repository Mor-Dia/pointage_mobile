import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/screens/Compte/MonCompte.dart';
import 'package:pointage_mobile/screens/home/dashboard_page.dart';
import 'package:pointage_mobile/screens/planning/Planning.dart';
import 'package:pointage_mobile/screens/pointages/pointages_page_new.dart';
import 'package:pointage_mobile/screens/settings/settings_page.dart';

class Mainhome extends StatefulWidget {
  const Mainhome({super.key});

  @override
  State<Mainhome> createState() => _MainhomeState();
}

class _MainhomeState extends State<Mainhome> {
  int _selectedIndex = 0;
  Key _homeKey = UniqueKey();
  Key _monCompteKey = UniqueKey();
  Key _pointagesKey = UniqueKey();
  Key _planningKey = UniqueKey();
  Key _settingsKey = UniqueKey();

  List<Widget> pages = [];

  void _onItemTapped(int index) {
    print("Mor Dia ${index}");
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _homeKey = UniqueKey();
      } else if (index == 1) {
        _planningKey = UniqueKey();
      } else if (index == 2) {
        _pointagesKey = UniqueKey();
      } else if (index == 3) {
        _monCompteKey = UniqueKey();
      } else if (index == 4) {
        _settingsKey = UniqueKey();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      DashboardPage(
        key: _homeKey,
      ),
      Planning(key: _planningKey, id: 0),
      PointagesPageNew(key: _pointagesKey),
      MonCompte(key: _monCompteKey),
      SettingsPage(key: _settingsKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        destinations: [
          // 1er onglet - Dashboard
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: greyColor,
              height: 25,
            ),
            label: '',
            selectedIcon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: const Color(0xFF10B981), // Vert
              height: 25,
            ),
          ),
          // 2ème onglet - Planning
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/fluent_tasks-app-28-filled.svg",
              color: greyColor,
              height: 25,
            ),
            label: '',
            selectedIcon: SvgPicture.asset(
              "assets/icons/fluent_tasks-app-28-filled.svg",
              color: const Color(0xFF10B981), // Vert
              height: 25,
            ),
          ),
          // 3ème onglet - Boutique
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/famicons_finger-print.svg",
              color: greyColor,
              height: 25,
            ),
            label: '',
            selectedIcon: SvgPicture.asset(
              "assets/icons/famicons_finger-print.svg",
              color: const Color(0xFF10B981), // Vert
              height: 25,
            ),
          ),
          // 4ème onglet - Mon Compte
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: greyColor,
              height: 25,
            ),
            label: '',
            selectedIcon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: const Color(0xFF10B981), // Vert
              height: 25,
            ),
          ),
          // 5ème onglet - Paramètres
          NavigationDestination(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: greyColor,
              height: 25,
            ),
            label: '',
            selectedIcon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: const Color(0xFF10B981), // Vert
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}
