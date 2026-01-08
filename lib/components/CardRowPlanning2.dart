import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pointage_mobile/components/ButtonField.dart';
import 'package:pointage_mobile/components/TopDialogNotification.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/core/utils/helpers.dart';

import '../services/api/models/reservation_model.dart';
import '../services/post_api_bloc.dart';
import 'animated_gesture_detector.dart';

class CardRowPlanning2 extends StatefulWidget {
  final Reservation reservation;
  final Function? updateFunction;
  const CardRowPlanning2(
      {super.key, required this.reservation, this.updateFunction});

  @override
  State<CardRowPlanning2> createState() => _CardRowPlanning2State();
}

class _CardRowPlanning2State extends State<CardRowPlanning2> {
  late PostApiBloc cancelReservationPostBloc;
  late Reservation reservation;
  bool enCours = false;

  @override
  void initState() {
    reservation = widget.reservation;
    cancelReservationPostBloc = PostApiBloc();
    checkIfReservationIsPassed();
    super.initState();
  }

  checkIfReservationIsPassed() {
    DateTime currentDate = DateTime.now();
    // String reservationDateTimeString = "${reservation.programme?.dateFr} ${reservation.programme?.heureDebut}";
    String reservationDateTimeString =
        "${reservation.programme?.dateFr} ${reservation.programme?.heureFin}";
    DateTime reservationDateTime =
        DateFormat("dd/MM/yyyy hh:mm").parse(reservationDateTimeString);
    if (currentDate.isBefore(reservationDateTime)) {
      setState(() {
        enCours = reservation.programme?.etat == "1" ? false : true;
      });
    }
  }

  cancelReservation({required Map<String, dynamic> parameters}) {
    Map<String, dynamic> params = {
      "etat": 1,
      "commentaire": "",
      "id": reservation.id,
      "fichier": ""
    };
    cancelReservationPostBloc.add(
        PostApiMakeCall(endpoint: 'reservation/statut', parameters: params));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: greyColor, width: 1))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spacingConstant),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: spacingConstant),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Helpers.firstLetterCapitalize(reservation
                        .programme?.professeurPratique?.pratique?.designation ??
                    ""),
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
                            width: 10,
                            color: const Color(0xFF838282),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            reservation.programme?.professeurPratique
                                    ?.professeur?.user?.name ??
                                "",
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
                            reservation.programme?.sallePratique?.salle
                                    ?.designation ??
                                "",
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
                        reservation.programme?.dateFr ?? "",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff838282)),
                      ),
                      Text(
                        enCours
                            ? "En cours "
                            : reservation.programme?.etat == "1"
                                ? enCours
                                    ? 'Annulé'
                                    : "Passé"
                                : '',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: enCours
                                ? const Color(0xff5EAB43)
                                : reservation.programme?.etat == "1"
                                    ? Colors.red
                                    : Colors.black38),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: enCours,
                    child: BlocConsumer(
                      bloc: cancelReservationPostBloc,
                      listener: (context, state) {
                        Color bgColor = Colors.green;
                        Color textColor = Colors.white;
                        String message = "";
                        if (state is PostApiSuccess) {
                          print("POST API SUCCESS ${state.message}");
                          message = "${state.message}";
                          bgColor = Colors.green;
                          if (widget.updateFunction != null) {
                            widget.updateFunction!();
                          }
                        } else if (state is PostApiFailure) {
                          print("POST API FAILURE ${state.message}");
                          message = "${state.message}";
                          bgColor = Colors.red;
                        }
                        if (state is PostApiSuccess) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          TopDialogNotification.show(context,
                              message: "${message}", isError: false);
                        }
                        if (state is PostApiFailure) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          TopDialogNotification.show(context,
                              message: "${message}", isError: true);
                        }
                        if (state is PostApiProcessing) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }
                      },
                      builder: (BuildContext context, postBlocState) {
                        return AnimatedGestureButton(
                            animate: postBlocState is PostApiProcessing,
                            child: ButtonFiled(
                              text: "Annuler",
                              color: Colors.red,
                              handlerPress: () {
                                cancelReservation(parameters: {});
                              },
                            ));
                      },
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
