import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:pointage_mobile/core/models/user_model.dart';
import 'package:pointage_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:pointage_mobile/screens/Home/MainHome.dart';
import 'package:pointage_mobile/core/utils/helpers.dart';
import 'package:pointage_mobile/services/notification_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _currentErrorMessage;
  String _emailError = '';
  String _passwordError = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    // Réinitialiser les erreurs
    setState(() {
      _emailError = '';
      _passwordError = '';
      _currentErrorMessage = null;
    });

    // Validation
    bool hasError = false;

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (_emailController.text.trim().isEmpty) {
      setState(() {
        _emailError = 'Ce champ est requis !';
      });
      hasError = true;
    } else if (!regex.hasMatch(_emailController.text.trim())) {
      setState(() {
        _emailError = 'Entrez un email valide!';
      });
      hasError = true;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Ce champ est requis !';
      });
      hasError = true;
    }

    if (hasError) return;

    // Lancer la connexion
    setState(() {
      _isLoading = true;
    });

    try {
      AuthenticationRepository authenticationRepository =
          RepositoryProvider.of<AuthenticationRepository>(context);

      Map<String, dynamic> data = {
        'email': _emailController.text.trim(),
        'password': _passwordController.text,
      };

      if (kDebugMode) {
        print("DATA TO SUBMIT $data");
      }

      final result = await authenticationRepository.logIn(data);
  print("result result result ${result}");
      setState(() {
        _isLoading = false;
      });

      if (result['status'] == 0) {
        // Erreur de connexion
        if (kDebugMode) {
          print("ERRORS ${result['errors']}");
        }

        setState(() {
          _currentErrorMessage = result['errors'] ?? "Erreur de connexion";
        });
      } else if (result['status'] == 1) {
        // Succès - le BlocConsumer gérera la navigation
        setState(() {
          _currentErrorMessage = null;
        });
      } else {
        setState(() {
          _currentErrorMessage = "Veuillez réessayer plus tard";
        });
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("ERROR $e $stacktrace");
      }
      setState(() {
        _isLoading = false;
        _currentErrorMessage = "Une erreur est survenue";
      });
    }
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    String error = '',
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: error.isNotEmpty ? Colors.red : const Color(0xffe4f2ee),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              hintText: hint,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Icon(icon, color: const Color(0xff20bfa9)),
              ),
            ),
          ),
        ),
        if (error.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 4),
            child: Text(
              error,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthenticationBloc<Utilisateur>,
        AuthenticationState<Utilisateur>>(
      listener: (context, state) async {
        AuthenticationStatus currentStatus = state.status;
        switch (currentStatus) {
          case AuthenticationStatus.authenticated:
            if (kDebugMode) {
              print("AUTH STATE AUTHENTICATED ${state.user!.id}");
            }

            // Gestion FCM
            Helpers.setFCMTokenToServer();
            NotificationApi.manageTokenFcm();

            // Navigation vers la page d'accueil
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Mainhome(),
                ),
                (route) => false);
            break;

          case AuthenticationStatus.unknown:
          case AuthenticationStatus.unauthenticated:
          case AuthenticationStatus.failure:
            if (kDebugMode) {
              print("AUTH STATE NOT AUTHENTICATED ${state.status}");
            }
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffb8f0e8), // Turquoise en haut
                  Color(0xffd4f5f0), // Turquoise moyen
                  Colors.white, // Blanc
                ],
                stops: [0.0, 0.08, 0.10],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Logo area
                  Container(
                    padding: const EdgeInsets.only(top: 36, bottom: 12),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 90,
                          child: Image.asset('assets/images/logos/Group1.png',
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  // Form fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildTextField(
                          hint: 'exemple@gmail.com',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          error: _emailError,
                        ),
                        const SizedBox(height: 14),
                        _buildTextField(
                          hint: 'Mot de passe',
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          obscure: true,
                          error: _passwordError,
                        ),
                        const SizedBox(height: 8),

                        // Message d'erreur général
                        if (_currentErrorMessage != null &&
                            _currentErrorMessage!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.info,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    _currentErrorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 4),

                        // Mot de passe oublié
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // TODO: Navigation vers reset password - décommente quand prêt
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const RequestPasswordScreen(),
                              //   ),
                              // );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Reset password flow')));
                            },
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                color: Colors.grey[700],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Bouton connexion
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _onLoginPressed,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor:
                                  const Color.fromARGB(255, 18, 154, 136),
                              elevation: 3,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Connexion',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
