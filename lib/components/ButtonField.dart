import 'package:flutter/material.dart';
import 'package:pointage_mobile/constant.dart';

class ButtonFiled extends StatelessWidget {
  final String text;
  final Function()? handlerPress;
  final bool? isLoading;
  final Color? color;
  const ButtonFiled(
      {super.key,
      required this.text,
      this.handlerPress,
      this.isLoading,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handlerPress,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: color ?? primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: textConstant),
          ),
          const SizedBox(
            width: 10,
          ),
          isLoading ?? isLoading == true
              ? const SizedBox(
                  height: 10,
                  width: 10,
                  child: Loader1(size: 8),
                  // CircularProgressIndicator(
                  //     strokeWidth: 1,
                  //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  //   ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
