import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  const NoDataWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          // dimension: 300,
          child: Lottie.asset(
            'assets/animations/nodata.json',
            repeat: true,
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
