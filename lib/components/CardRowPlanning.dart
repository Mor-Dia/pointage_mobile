import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';

class CardRowPlanning extends StatefulWidget {
  final Programme data;
  const CardRowPlanning({super.key, required this.data});

  @override
  State<CardRowPlanning> createState() => _CardRowPlanningState();
}

class _CardRowPlanningState extends State<CardRowPlanning> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: greyColor))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.professeurPratique!.pratique!.designation
                    .toString()
                    .toCapitalized
                    .toString(),
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
                                  Text(
                                    widget.data.heureDebut.toString(),
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
                                  Container(
                                    width: 50,
                                    child: Expanded(
                                      child: Text(
                                        widget.data.professeurPratique!
                                            .professeur!.user!.name
                                            .toString()
                                            .toCapitalized,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xff838282),
                                            fontSize: 10),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
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
                                  Text(
                                    widget.data.heureFin.toString(),
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
