import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class PleaseLoginWidget extends StatelessWidget {
  final String? message;
  const PleaseLoginWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          // dimension: 300,
          child: Lottie.asset(
            'assets/animations/pleaselogin.json',
            repeat: false,
            reverse: false,
            animate: true,
          ),
        ),
        Text(
          "Veuillez vous connectez",
        ),
      ],
    );
  }
}
