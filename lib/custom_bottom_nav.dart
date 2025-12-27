import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constant.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav(
      {super.key, required this.currentIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12,
      unselectedFontSize: 11,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 0 ? primaryColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/planning.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 1 ? primaryColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Planifications',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/taches_icon.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? primaryColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Tâches',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/stat.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 3 ? primaryColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Statistiques',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/compte.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 4 ? primaryColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Compte',
        ),
      ],
    );
  }
}
