import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/CardActivite.dart';
import 'package:yogivida_mobile/components/CardPratique.dart';
import 'package:yogivida_mobile/components/CustomBottomNavigationBar.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yogivida_mobile/screens/Home/NotificationPage.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc_helpers.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';

import '../../services/api/models/programme_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DataBloc<List<Pratique>> practiceBloc;
  late DataBloc<List<Programme>> programmeBloc;
  Map<String, dynamic> globalFilter = {"count" : 4};


  @override
  void initState() {
    practiceBloc = DataBloc<List<Pratique>>(
            (response) => Pratique.fromJsonList(response),
        Pratique.getEndpoint(isPagination: true),
        isGraphQl: true, isPagination: true,
        attributeToGet: Pratique.shrinkedAttributs()
    );
    programmeBloc = DataBloc<List<Programme>>(
            (response) => Programme.fromJsonList(response),
        Programme.getEndpoint(isPagination: true),
        isGraphQl: true, isPagination: true,
        attributeToGet: Programme.shrinkedAttributs()
    );
    practiceBloc.add(FetchDataEvent(filter: globalFilter));
    programmeBloc.add(FetchDataEvent(filter: globalFilter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        automaticallyImplyLeading: false, // Empêche l'affichage du bouton back
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Accueil',
              style: GoogleFonts.arimo(
                color: const Color(0xff15274d),
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsPage())),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xff15274d),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/bell.svg',
                        width: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -5,
                    top: -5,
                    child: Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5, color: Colors.white)),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '8', // Remplacez '3' par le nombre de notifications dynamiquement
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                child: Text(
                  "Votre activité du jour",
                  style: GoogleFonts.montserrat(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBasedWidget<List<Programme>>(
              customDataBloc: programmeBloc,
              customWidget: (data) {
                print("DATA BLOC BASED DATA $data");
                List<Programme> programmes = data;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...programmes
                          .map((toElement) => Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Cardactivite(
                              data: toElement,
                              color: toElement.displaycoloretat ?? "",
                              handlePress: () {
                                ShowBottomSheet(context);
                              })
                        ],
                      ))
                          .toList(),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                child: Text(
                  "Nos pratiques",
                  style: GoogleFonts.montserrat(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBasedWidget<List<Pratique>>(
              customDataBloc: practiceBloc,
              customWidget: (data) {
                print("DATA BLOC BASED DATA $data");
                List<Pratique> pratiques = data;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...pratiques
                          .map((toElement) => Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          CardPratique(
                            data: toElement,
                            handlePress: () => ShowBottomSheet(context),
                          )
                        ],
                      ))
                          .toList(),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [Text("hello")],
            ),
          );
        });
  }
}
