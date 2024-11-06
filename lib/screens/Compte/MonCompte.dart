import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Compte/Commandes.dart';
import 'package:yogivida_mobile/screens/Compte/Favoris.dart';
import 'package:yogivida_mobile/screens/Compte/LigneCredit.dart';
import 'package:yogivida_mobile/screens/Compte/LocalisationContact.dart';
import 'package:yogivida_mobile/screens/Compte/Reservation.dart';
import 'package:yogivida_mobile/screens/Compte/Update.dart';

class MonCompte extends StatefulWidget {
  const MonCompte({super.key});

  @override
  State<MonCompte> createState() => _MonCompteState();
}

class _MonCompteState extends State<MonCompte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0,
        automaticallyImplyLeading: false, // Empêche l'affichage du bouton back
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mon compte',
              style: GoogleFonts.arimo(
                color: Color(0xff15274d),
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Update())),
                  child: Container(
                    height: 50,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff15274d),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/pen.svg',
                        width: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(children: [
          SizedBox(height: 20),
          Center(
            child: Column(children: [
              SvgPicture.asset(
                "assets/icons/user2.svg",
                width: 70,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Papa Thiam',
                style: TextStyle(color: primaryColor, fontSize: 16),
              )
            ]),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LigneCredit()),
                      )
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Color(0xff5EAB43)),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mes lignes crédit",
                            style: TextStyle(color: Color(0xff5EAB43)),
                          ),
                          Text(
                            '20 000' + 'xof'.toUpperCase(),
                            style: TextStyle(
                                color: Color(0xff5EAB43),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 10),
                // Expanded(
                //   child: Container(
                //     height: 80,
                //     decoration: BoxDecoration(
                //         border: Border.all(width: 1, color: Color(0xff838282)),
                //         borderRadius: BorderRadius.circular(8)),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           "Mes abonnements",
                //           style: TextStyle(color: Color(0xff838282)),
                //         ),
                //         Text(
                //           '2'.toUpperCase(),
                //           style: TextStyle(
                //               color: Color(0xff838282),
                //               fontWeight: FontWeight.bold),
                //         )
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reservation()),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(width: 1, color: greyColor))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/historique.svg"),
                        SizedBox(width: 10),
                        Text(
                          "Historique des réservations",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Commandes()),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(width: 1, color: greyColor))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/boutique.svg",
                          color: primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Mes commandes",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favoris()),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(width: 1, color: greyColor))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/like.svg",
                          color: primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Favoris",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocalisationContact()),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(width: 1, color: greyColor))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/carte.svg",
                          color: primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Localisation et contact",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: greyColor))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/off.svg",
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Déconnexion",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: greyColor))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/trash.svg",
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Supprimer le compte",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
