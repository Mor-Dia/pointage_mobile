import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/CardRowPlanning.dart';
import 'package:yogivida_mobile/components/CardRowPlanning2.dart';
import 'package:yogivida_mobile/constant.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
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
                'Mes Reservations',
                style: GoogleFonts.arimo(
                  color: primaryColor,
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
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
          child: const TabBarView(
            children: [
              ScrollableTabPage(
                data: [1, 2],
              ),
              ScrollableTabPage(data: [1])
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollableTabPage extends StatelessWidget {
  final List data;

  const ScrollableTabPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: data.map((toElement) => const CardRowPlanning2()).toList(),
      ),
    );
  }
}
