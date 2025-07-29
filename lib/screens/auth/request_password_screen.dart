import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/notifier_dialog.dart';
import 'login_screen.dart';

class RequestPasswordScreen extends StatefulWidget {
  const RequestPasswordScreen({super.key});

  @override
  State<RequestPasswordScreen> createState() => _RequestPasswordScreenState();
}

class _RequestPasswordScreenState extends State<RequestPasswordScreen> {
  bool isLoading = false;
  String? currentErrorMessage;
  String? emailError;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future requestPassword() async {
    setState(() {
      isLoading = true;
    });

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    bool _areFieldsEmpty() {
      var isValid = true;
      setState(() {
        emailError = '';
      });
      if (emailController.text.isEmpty) {
        setState(() {
          emailError = 'Ce champ est requis !';
          isValid = false;
        });
      } else if (!regex.hasMatch(emailController.text.trim())) {
        setState(() {
          emailError = 'Entrez un email valide!';
          isValid = false;
        });
      }
      return isValid;
    }

    bool isFormValid = _areFieldsEmpty();
    print("REQUE IS FORM VALID $isFormValid");

    if (isFormValid) {
      String requestUrl = "$BASE_URL$REQUEST_PWD_ENDPOINT";
      var requestUri = Uri.parse(requestUrl);
      Map<String, String> headers = {};
      Map<String, dynamic> postData = {
        "email": emailController.text,
      };

      print("REQUE URI $requestUri");
      headers.addAll(
          {"Accept": "application/json", "Content-Type": "application/json"});
      var requestPwdResponse = await http.post(requestUri,
          body: jsonEncode(postData), headers: headers);
      var responseBody =
          jsonDecode(requestPwdResponse.body) as Map<String, dynamic>;
      String message = "";
      bool isError = false;
      print("REQUE RESP $responseBody");
      if (responseBody['message'] != null) {
        message = responseBody['message'];
        isError = false;
        // Navigator.pop(context); // Ferme la page actuelle si succès
      } else if (responseBody.containsKey("errors") &&
          responseBody['errors'] != null) {
        message = responseBody['errors'];
        isError = true;
      }
      showNotifyingDialog(
        context: context,
        message: "Réussie",
        isError: false,
        onClose: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
      );
      // showNotifyingDialog(context: context, message: message, isError: isError);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(spacingConstant),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centrer verticalement
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Aligner à gauche
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/logos/logo.svg',
                              height: 80,
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.1), // Espacement pour centrer verticalement
                        const SizedBox(
                            height: 30), // Espacement entre le logo et le texte
                        Text(
                          'Réinitialiser le mot de passe !',
                          style: GoogleFonts.alata(
                            fontSize: MediaQuery.of(context).size.width * 0.085,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          'Yoga pour le corps, l\'esprit et l\'âme.',
                          style: GoogleFonts.montserrat(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: const Color(0xff15274d),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 30),

                        Column(children: [
                          Inputfiled(
                            type: "email",
                            text: "Email",
                            icon: 'user',
                            controller: emailController,
                            error:
                                emailError ?? "", // L'erreur est vide au départ
                          ),
                          const SizedBox(height: 30),
                        ]),
                        Center(
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Visibility(
                                      visible: currentErrorMessage != null &&
                                          currentErrorMessage != null,
                                      child: const Icon(
                                        Icons.info,
                                        color: Colors.red,
                                        size: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      currentErrorMessage ?? "",
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ), // Espacement en bas pour mieux centrer
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    ButtonFiled(
                      isLoading: isLoading,
                      text: 'Réinitialiser',
                      handlerPress: () => {
                        requestPassword(),
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vous n’avez pas de compte ? ',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.030,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterScreen(),
                                ),
                                (route) => false);
                          },
                          child: Text(
                            'Inscrivez-vous !',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.030,
                              color: const Color(0xff15274d),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vous avez un compte ? ',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.030,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen(),
                                ),
                                (route) => false);
                          },
                          child: Text(
                            'Connectez-vous !',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.030,
                              color: const Color(0xff15274d),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
