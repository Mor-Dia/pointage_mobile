import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';

class CardRowPlanning extends StatefulWidget {
  const CardRowPlanning({super.key});

  @override
  State<CardRowPlanning> createState() => _CardRowPlanningState();
}

class _CardRowPlanningState extends State<CardRowPlanning> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(border: Border.all(color: greyColor, width: 1)),
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
              Row(
                children: [
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                height: 10,
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
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    '16h20',
                                    style: TextStyle(
                                        color: Color(0xff838282), fontSize: 10),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
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
                        ]),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: ButtonFiled(
                    text: 'Reserver',
                    handlerPress: () => {},
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
