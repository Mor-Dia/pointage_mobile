import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pointage_mobile/components/CardRowPlanning.dart';
import 'package:pointage_mobile/components/CardRowPlanning2.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/services/api/models/reservation_model.dart';
import 'package:pointage_mobile/services/data_bloc/presentation/bloc_based_widget.dart';
import 'package:pointage_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:pointage_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:pointage_mobile/core/models/user_model.dart';
import 'package:pointage_mobile/components/please_login_widget.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({super.key});

  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  late DataBloc<List<Reservation>> reservationBloc0;
  late DataBloc<List<Reservation>> reservationBloc1;
  Map<String, dynamic> globalFilter = {"count": 10};
  Map<String, dynamic> filter1 = {"count": 10};
  Map<String, dynamic> filter0 = {"count": 10};
  final DateTime date = DateTime.now();

  @override
  void initState() {
    reservationBloc0 = DataBloc<List<Reservation>>(
        (response) => Reservation.fromJsonList(response),
        Reservation.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Reservation.shrinkedAttributs());

    reservationBloc1 = DataBloc<List<Reservation>>(
        (response) => Reservation.fromJsonList(response),
        Reservation.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Reservation.shrinkedAttributs());

    filter0.addAll({'statut': 'en_cours'});
    filter1.addAll({'statut': 'terminer'});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: greyColorL, borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/back.svg'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          toolbarHeight: 60,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mes Réservations',
                style: GoogleFonts.arimo(
                  color: primaryColor,
                  fontSize: titreConstant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: const BorderSide(
                color: primaryColor,
                width: 1.0, // Épaisseur du trait sous l'onglet actif
              ),
              insets: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.30),
              // 0.25 sur chaque côté pour que le trait fasse 50% de la largeur de l'onglet
            ),
            indicatorColor: primaryColor,
            indicatorWeight: 1.0, // Épaisseur du trait sous l'onglet actif
            indicatorSize:
                TabBarIndicatorSize.label, // Le trait prend la largeur du texte
            labelColor: primaryColor, // Couleur du texte actif
            unselectedLabelColor: greyColor, // Couleur du texte inactif
            tabs: const [
              Tab(text: 'En cours'),
              Tab(text: 'Passées'),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              ScrollableTabPage(
                reservationBloc: reservationBloc0,
                currentFilter: filter0,
              ),
              ScrollableTabPage(
                reservationBloc: reservationBloc1,
                currentFilter: filter1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollableTabPage extends StatelessWidget {
  final DataBloc<List<Reservation>> reservationBloc;
  final Map<String, dynamic> currentFilter;

  const ScrollableTabPage(
      // {Key? key, required this.reservationBloc, this.currentFilter = const {}})
      {Key? key,
      required this.reservationBloc,
      this.currentFilter = const {}})
      : super(key: key);

  updateList(newFilter) {
    reservationBloc.add(FetchDataEvent(filter: newFilter));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocBuilder<AuthenticationBloc<Utilisateur>,
        AuthenticationState<Utilisateur>>(builder: (context, authState) {
      AuthenticationStatus currentStatus = authState.status;
      int? clientId = authState.user?.id;
      print("AUTH USER ${authState.user}");
      switch (currentStatus) {
        case AuthenticationStatus.authenticated:
          return BlocBasedWidget<List<Reservation>>(
            customDataBloc: reservationBloc,
            filter: {...currentFilter, "client_id": clientId},
            useInfiniteScroller: true,
            customWidget: (state) {
              List<Reservation> reservations = state.data;

              if (reservations.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: const Center(
                    child: Text("Aucune réservation n'est disponible"),
                  ),
                );
              }

              return Column(children: [
                const SizedBox(
                  height: spacingConstant,
                ),
                ...reservations
                    .map((toElement) => CardRowPlanning2(
                        reservation: toElement,
                        updateFunction: () => updateList(
                            {...currentFilter, "client_id": clientId})))
                    .toList(),
              ]);
            },
          );
        case AuthenticationStatus.unknown:
        case AuthenticationStatus.unauthenticated:
        case AuthenticationStatus.failure:
          return const Center(child: PleaseLoginWidget());
      }
    });
  }
}
