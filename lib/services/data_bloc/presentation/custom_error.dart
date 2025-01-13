import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? message;
  const CustomErrorWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          // dimension: 300,
          child: Lottie.asset(
            'assets/animations/error.json',
            repeat: false,
            reverse: false,
            animate: true,
          ),
        ),
        Text(
          message ?? "",
        ),
      ],
    );
  }
}
