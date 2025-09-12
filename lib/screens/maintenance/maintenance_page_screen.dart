import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:in_app_review/in_app_review.dart';

class MaintenancePageScreen extends StatelessWidget {
  final String? image;
  const MaintenancePageScreen({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff15274d),
      body: Center(
        child: Image.network(
        image!,
        fit: BoxFit.cover,
        
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text(
              "Erreur lors du chargement de l'image.",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      )
    );
  }
}
