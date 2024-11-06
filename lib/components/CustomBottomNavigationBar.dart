import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/constant.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<String> urls; // Liste des URLs à passer pour la navigation
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar(
      {Key? key, required this.urls, required this.onTap})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    widget.onTap;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
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
          selectedIcon: Column(
            children: [
              SvgPicture.asset(
                "assets/icons/home.svg",
                color: primaryColor,
                height: 25,
              ),
              SizedBox(height: 10),
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffA8923B),
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
          selectedIcon: Column(
            children: [
              SvgPicture.asset(
                "assets/icons/planning.svg",
                color: primaryColor,
                height: 25,
              ),
              SizedBox(height: 10),
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffA8923B),
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
          selectedIcon: Column(
            children: [
              SvgPicture.asset(
                "assets/icons/boutique.svg",
                color: primaryColor,
                height: 25,
              ),
              SizedBox(height: 10),
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffA8923B),
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
          selectedIcon: Column(
            children: [
              SvgPicture.asset(
                "assets/icons/compte.svg",
                color: primaryColor,
                height: 25,
              ),
              SizedBox(height: 10),
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffA8923B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
