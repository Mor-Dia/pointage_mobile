import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';

class Update extends StatefulWidget {
  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String selectedGender = 'Homme';
  // Valeur par défaut pour le genre
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: greyColorL, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: SvgPicture.asset('assets/icons/back.svg'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Modifier votre compte',
              style: GoogleFonts.arimo(
                color: primaryColor,
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Centrer verticalement
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligner à gauche
                    children: [
                      SizedBox(
                          height: 20), // Espacement pour centrer verticalement
                      Inputfiled(
                        type: 'text',
                        text: "Nom d'utilisateur",
                        icon: 'user',
                      ),
                      SizedBox(height: 30),
                      Inputfiled(
                        type: 'text',
                        text: 'Email',
                        icon: 'mail',
                      ),
                      SizedBox(height: 30),
                      Inputfiled(
                        type: 'text',
                        text: 'Numéro de téléphone',
                        icon: 'phone',
                      ),
                      SizedBox(height: 30),
                      Inputfiled(
                        type: 'select',
                        text: 'Genre',
                        icon: '',
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          'Modifier votre mot de passe',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Inputfiled(
                              type: 'password',
                              text: "Entrez l'ancien mot de passe",
                              icon: '',
                            ),
                          ),
                          SizedBox(width: 10),
                          IntrinsicWidth(
                            child: ButtonFiled(
                              text: "Valider",
                              handlerPress: () => {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Inputfiled(
                        type: 'password',
                        text: 'Nouveau mot de passe',
                        icon: '',
                      ),
                      SizedBox(height: 30),
                      Inputfiled(
                        type: 'password',
                        text: 'Confirmer le mote de passe',
                        icon: '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 30),
                ButtonFiled(
                  text: "Enregistrer",
                  handlerPress: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Mainhome()),
                    )
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
