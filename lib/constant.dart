import 'package:flutter/material.dart';

final Color primaryColor = Color(0xff15274D);
final Color greyColor = Color(0xffD9D9D9);
final Color greyColorL = Color(0xffF1F1F1);
final Color secondColor = Color(0xffA8923B);
final padding_constant = 20.0;

class Activite {
  final String nomActivite;
  final String nomProf;
  final String heure;
  final int color;

  Activite(this.nomActivite, this.nomProf, this.heure, this.color);
}

class Pratique {
  final String nomPratique;
  final String image;
  final bool liked;

  Pratique(this.nomPratique, this.image, this.liked);
}
