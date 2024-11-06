import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Inputfiled extends StatefulWidget {
  final String type;
  final String text;
  final String? icon;
  final Color? bgColor;
  final Color? textColor;

  const Inputfiled(
      {super.key,
      required this.type,
      required this.text,
      this.icon,
      this.bgColor,
      this.textColor});

  @override
  State<Inputfiled> createState() => _InputfiledState();
}

class _InputfiledState extends State<Inputfiled> {
  @override
  bool hide = true;
  String? _selectedValue;
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xff15274d)),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: widget.type != "select"
          ? Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: TextField(
                obscureText: widget.type == "password" ? hide : false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 6.5),
                  hintText: widget.text,
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035),
                  prefixIcon: SvgPicture.asset(
                    color: Color(0xff15274d),
                    widget.type == 'password'
                        ? 'assets/icons/lock.svg'
                        : 'assets/icons/' + widget.icon.toString() + '.svg',
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
                            hide ? Icons.visibility_off : Icons.remove_red_eye,
                            size: 20,
                            color: Color(0xff15274d),
                          ),
                        )
                      : null,
                ),
              ),
            )
          : Container(
              child: DropdownButton<String>(
                value: _selectedValue,
                underline: SizedBox.shrink(),
                isExpanded: true,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                hint: Text(widget.text),
                style: TextStyle(
                    color: Color(0xff15274d),
                    fontSize: MediaQuery.of(context).size.width * 0.035),
                icon: SvgPicture.asset('assets/icons/arrow_b.svg'),
                items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
              ),
            ),
    );
  }
}
