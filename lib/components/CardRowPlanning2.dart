import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/helpers.dart';

import '../services/api/models/reservation_model.dart';

class CardRowPlanning2 extends StatefulWidget {
  final Reservation reservation;

  const CardRowPlanning2({super.key, required this.reservation});

  @override
  State<CardRowPlanning2> createState() => _CardRowPlanning2State();
}

class _CardRowPlanning2State extends State<CardRowPlanning2> {
  late Reservation reservation;
  bool enCours = false;

  @override
  void initState() {
    reservation = widget.reservation;
    checkIfReservationIsPassed();
    super.initState();
  }

  checkIfReservationIsPassed(){
    DateTime currentDate = DateTime.now();
    String reservationDateTimeString = "${reservation.programme?.dateFr} ${reservation.programme?.heureDebut}";
    DateTime reservationDateTime = DateFormat("dd/MM/yyyy hh:mm").parse(reservationDateTimeString);
    if(currentDate.isBefore(reservationDateTime)){
      setState(() {
        enCours = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: greyColor, width: 1))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Helpers.firstLetterCapitalize(reservation.programme?.professeurPratique?.pratique?.designation ?? ""),
                style: const TextStyle(
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
                          Text(
                            reservation.programme?.heureDebut ?? "",
                            style: const TextStyle(
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
                          Text(
                            reservation.programme?.professeurPratique?.professeur?.user?.name ?? "",
                            style: const TextStyle(
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
                          Text(
                            reservation.programme?.heureFin ?? "",
                            style: const TextStyle(
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
                          Text(
                            reservation.programme?.sallePratique?.salle?.designation ?? "",
                            style: const TextStyle(
                                color: Color(0xff838282), fontSize: 10),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        reservation.programme?.dateFr?? "",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff838282)),
                      ),
                      Text(
                        enCours? "En cours " : "Passé",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: enCours? const Color(0xff5EAB43) : Colors.black38
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: enCours,
                    child: ButtonFiled(
                      text: 'Annuler',
                      handlerPress: () => {},
                    ),
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
