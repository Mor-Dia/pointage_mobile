import 'package:flutter/material.dart';

class ButtonFiled extends StatelessWidget {
  final String text;
  final Function()? handlerPress;
  final bool? isLoading;
  const ButtonFiled(
      {super.key, required this.text, this.handlerPress, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handlerPress,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: const Color(0xff15274d),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.030),
          ),
          SizedBox(
            width: 10,
          ),
          isLoading ?? isLoading == true
              ? Container(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
