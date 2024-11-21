import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/CardActivite.dart';
import 'package:yogivida_mobile/components/CardPratique.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/NotificationPage.dart';
import 'package:yogivida_mobile/screens/Home/pratique_page.dart';
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
  Map<String, dynamic> globalFilter = {"count": 5};
  final DateTime date = new DateTime.now();

  @override
  void initState() {
    practiceBloc = DataBloc<List<Pratique>>(
        (response) => Pratique.fromJsonList(response),
        Pratique.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Pratique.shrinkedAttributs());
    programmeBloc = DataBloc<List<Programme>>(
        (response) => Programme.fromJsonList(response),
        Programme.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Programme.shrinkedAttributs());
    practiceBloc.add(FetchDataEvent(filter: globalFilter));
    programmeBloc.add(FetchDataEvent(filter: {
      ...globalFilter,
      'date': '${date.year}-${date.month}-${date.day}'
    }));
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
                color: Color(0xff15274d),
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
              customWidget: (state) {
                List<Programme> programmes = state.data;
                Map<String, dynamic>? metadata = state.metadata;
                bool canLoadNewData = state.canLoadNewData;
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nos pratiques",
                      style: GoogleFonts.montserrat(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PratiquesPage()));
                      },
                      child: Icon(
                        Icons.arrow_outward_rounded,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBasedWidget<List<Pratique>>(
              customDataBloc: practiceBloc,
              customWidget: (state) {
                List<Pratique> pratiques = state.data;
                Map<String, dynamic>? metadata = state.metadata;
                bool canLoadNewData = state.canLoadNewData;
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
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 2,
                      width: 50,
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pilate former groupe'.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Ouvert",
                        style: TextStyle(color: primaryColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/heure.svg",
                        height: 15,
                        color: const Color(0xFF838282),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "14H50",
                        style:
                            TextStyle(color: Color(0xff838282), fontSize: 12),
                      ),
                      Text(
                        "- 14H50",
                        style:
                            TextStyle(color: Color(0xff838282), fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffE5DFC5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    "assets/icons/heure.svg",
                                    height: 15,
                                    color: const Color(0xFFA8923B),
                                  ))),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mins",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "14H50",
                                style: TextStyle(
                                    color: Color(0xff838282), fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffE5DFC5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    "assets/icons/heure.svg",
                                    height: 15,
                                    color: const Color(0xFFA8923B),
                                  ))),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mins",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "14H50",
                                style: TextStyle(
                                    color: Color(0xff838282), fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffE5DFC5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    "assets/icons/heure.svg",
                                    height: 15,
                                    color: const Color(0xFFA8923B),
                                  ))),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mins",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "14H50",
                                style: TextStyle(
                                    color: Color(0xff838282), fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'lorem',
                    style: TextStyle(color: Color(0xff838282), fontSize: 12),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Spacer(flex: 1),
                  Center(
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.50),
                      child: ButtonFiled(
                        text: 'Reserver',
                        handlerPress: () => ShowBottomSheetPayment(context),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

Future<dynamic> ShowBottomSheetPayment(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 2,
                    width: 50,
                    decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Payer par '.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: greyColorL),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/lc.svg',
                          height: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Ligne crédit',
                            style: TextStyle(color: primaryColor)),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Solde actuel',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 12)),
                            Text('20.000' + ' xof'.toUpperCase(),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: greyColorL),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/wv.png',
                          height: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Wave', style: TextStyle(color: primaryColor))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: greyColorL),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/om.png',
                          height: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Orange Money',
                            style: TextStyle(color: primaryColor))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
