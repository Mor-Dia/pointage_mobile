import 'package:flutter/material.dart';
import '../custom_bottom_nav.dart';
import 'Home/home_page.dart';
import 'Planning/Planning.dart';
import 'taches/taches_page.dart';
import 'statistiques/statistiques_page.dart';
import 'Compte/MonCompte.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Planning(id: 1), // Utilise Planning.dart existant
    const TachesPage(),
    const StatistiquesPage(),
    const MonCompte(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
