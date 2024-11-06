import 'package:flutter/material.dart';

class ButtonFiled extends StatelessWidget {
  final String text;
  final Function()? handlerPress;
  const ButtonFiled({super.key, required this.text, this.handlerPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handlerPress,
      child: Text(
        this.text,
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.030),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Color(0xff15274d),
      ),
    );
  }
}
