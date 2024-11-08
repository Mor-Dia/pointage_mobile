import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/constant.dart';

class Inputfiled extends StatefulWidget {
  final String type;
  final String text;
  final String? icon;
  final String? error;
  final Color? bgColor;
  final Color? textColor;
  final TextEditingController? controller;

  const Inputfiled(
      {super.key,
      required this.type,
      required this.text,
      this.icon,
      this.bgColor,
      this.textColor,
      this.controller,
      this.error});

  @override
  State<Inputfiled> createState() => _InputfiledState();
}

class _InputfiledState extends State<Inputfiled> {
  @override
  bool hide = true;
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xff15274d)),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: widget.type != "select"
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextField(
                    obscureText: widget.type == "password" ? hide : false,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(top: 6.5),
                      hintText: widget.text,
                      hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035),
                      prefixIcon: SvgPicture.asset(
                        color: const Color(0xff15274d),
                        widget.type == 'password'
                            ? 'assets/icons/lock.svg'
                            : 'assets/icons/${widget.icon}.svg',
                        fit: BoxFit.scaleDown,
                        height: 20,
                      ),
                      suffixIcon: widget.type == 'password'
                          ? IconButton(
                              onPressed: () => {
                                setState(() {
                                  hide = !hide;
                                })
                              },
                              icon: Icon(
                                hide
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                                size: 20,
                                color: const Color(0xff15274d),
                              ),
                            )
                          : null,
                    ),
                  ),
                )
              : Container(
                  child: DropdownButton<String>(
                    value: _selectedValue,
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    hint: Text(widget.text),
                    dropdownColor: primaryColor,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.035),
                    icon: SvgPicture.asset('assets/icons/arrow_b.svg'),
                    items: <String>['Homme', 'Femme'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: primaryColor),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                  ),
                ),
        ),
        widget.error!.isNotEmpty
            ? Text(
                widget.error!.toString(),
                style: TextStyle(color: Colors.red, fontSize: 11),
              )
            : SizedBox.shrink()
      ],
    );
  }
}
