import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pointage_mobile/components/TopDialogNotification.dart';
import 'package:pointage_mobile/screens/Home/MainHome.dart';
import 'package:pointage_mobile/screens/auth/login_screen.dart';

class UpdatePageScreen extends StatelessWidget {
  final String? message;
  final bool? forceUpdate;

  const UpdatePageScreen({super.key, this.message, this.forceUpdate});

  @override
  Widget build(BuildContext context) {
    Future<void> goToStore() async {
      final InAppReview inAppReview = InAppReview.instance;
      try {
        if (await inAppReview.isAvailable()) {
        await inAppReview.openStoreListing(
            appStoreId: '6742237215',
          );
        } else {
          TopDialogNotification.show(
            context,
            message:
                "Impossible d’ouvrir le store automatiquement. Rendez-vous dans votre store et procédez à la mise à jour.",
            isError: true,
          );
        }
      } catch (exception, stackTrace) {
        TopDialogNotification.show(
          context,
          message:
              "Rendez-vous dans votre store et procédez à la mise à jour. Merci !",
          isError: true,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              // <-- Ajouté pour rendre scrollable
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      40, // Ajuste pour le padding
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logos/logo.svg",
                        height: 60,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "🚀 Mise à jour disponible !",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff15274d),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Icon(
                        Icons.system_update,
                        color: Color(0xff15274d),
                        size: 30,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Une nouvelle version est prête. Veuillez mettre à jour pour profiter des dernières fonctionnalités et améliorations.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (message!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Html(
                          data: message,
                          style: {
                            "body": Style(
                              fontSize: FontSize(14),
                              color: Colors.black87,
                              textAlign: TextAlign.left,
                            ),
                          },
                        ),
                      ],
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (forceUpdate == false)
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Color(0xff15274d), width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => const Mainhome()),
                                    (route) => false,
                                  );
                              },
                              child: const Text(
                                "Plus tard",
                                style: TextStyle(
                                  color: Color(0xff15274d),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          if (forceUpdate == false) const SizedBox(width: 14),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff15274d),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              elevation: 3,
                            ),
                            onPressed: () => goToStore(),
                            child:const Text(
                              "Mettre à jour",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
