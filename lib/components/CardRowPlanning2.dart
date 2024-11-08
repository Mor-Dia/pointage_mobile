import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';

class CardRowPlanning2 extends StatefulWidget {
  const CardRowPlanning2({super.key});

  @override
  State<CardRowPlanning2> createState() => _CardRowPlanning2State();
}

class _CardRowPlanning2State extends State<CardRowPlanning2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: greyColor, width: 1))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pilate reformer groupe - S1",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/heure.svg",
                            color: const Color(0xFF838282),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            '14h20',
                            style: TextStyle(
                                color: Color(0xff838282), fontSize: 10),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/person.svg",
                            color: const Color(0xFF838282),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Marzena',
                            style: TextStyle(
                                color: Color(0xff838282), fontSize: 10),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/heure.svg",
                            color: const Color(0xFF838282),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            '16h20',
                            style: TextStyle(
                                color: Color(0xff838282), fontSize: 10),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/loc.svg",
                            color: const Color(0xFF838282),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Dakar plateau',
                            style: TextStyle(
                                color: Color(0xff838282), fontSize: 10),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ajourd'hui",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff838282)),
                      ),
                      Text(
                        "En cours ",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff5EAB43)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonFiled(
                    text: 'Reserver',
                    handlerPress: () => {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
