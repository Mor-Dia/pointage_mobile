import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/components/CustomBottomNavigationBar.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Boutique/Boutique.dart';
import 'package:yogivida_mobile/screens/Compte/MonCompte.dart';
import 'package:yogivida_mobile/screens/home/home_page.dart';
import 'package:yogivida_mobile/screens/planning/Planning.dart';

class Mainhome extends StatefulWidget {
  const Mainhome({super.key});

  @override
  State<Mainhome> createState() => _MainhomeState();
}

class _MainhomeState extends State<Mainhome> {
  @override
  int _selectedIndex = 0;

  // Liste des pages à afficher dans l'IndexedStack
  final List<Widget> _pages = [
    HomePage(),
    const Planning(),
    const Boutique(),
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
        bottomNavigationBar: NavigationBar(
          animationDuration: const Duration(milliseconds: 500),
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                color: greyColor,
                height: 25,
              ),
              label: '',
              selectedIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/icons/home.svg",
                    color: primaryColor,
                    height: 25,
                  ),
                  Positioned(
                    bottom: -spacingConstant,
                    left: 10,
                    child: Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffA8923B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/planning.svg",
                color: greyColor,
                height: 25,
              ),
              label: '',
              selectedIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/icons/planning.svg",
                    color: primaryColor,
                    height: 25,
                  ),
                  Positioned(
                    bottom: -spacingConstant,
                    left: 10,
                    child: Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffA8923B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/boutique.svg",
                color: greyColor,
                height: 25,
              ),
              label: '',
              selectedIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/icons/boutique.svg",
                    color: primaryColor,
                    height: 25,
                  ),
                  Positioned(
                    bottom: -spacingConstant,
                    left: 10,
                    child: Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffA8923B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                "assets/icons/compte.svg",
                color: greyColor,
                height: 25,
              ),
              label: '',
              selectedIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/icons/compte.svg",
                    color: primaryColor,
                    height: 25,
                  ),
                  Positioned(
                    bottom: -spacingConstant,
                    left: 10,
                    child: Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffA8923B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
