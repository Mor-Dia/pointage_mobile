import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yogivida_mobile/components/CardRowPlanning.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
import 'package:yogivida_mobile/screens/Home/NotificationPage.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';
import 'package:yogivida_mobile/services/api/models/salle_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

import '../../services/api/models/notificationpush_model.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  var selectedValue;
  late DataBloc<List<Programme>> programmeBloc;
  final List<String> options = [];
  TextEditingController designationFilter = TextEditingController();
  late DataBloc<List<NotificationPush>> notificationPushBloc;

  final DateTime date = new DateTime.now();

  @override
  void initState() {
    programmeBloc = DataBloc<List<Programme>>(
        (response) => Programme.fromJsonList(response),
        Programme.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Programme.shrinkedAttributs());

    programmeBloc.add(FetchDataEvent(
        filter: {'date': '${date.year}-${date.month}-${date.day}'}));

    notificationPushBloc = DataBloc<List<NotificationPush>>(
        (response) => NotificationPush.fromJsonList(response),
        NotificationPush.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: NotificationPush.shrinkedAttributs());

    super.initState();
  }

  List<Salle?> extractStudiosOptions(List<Programme> programmes){
    List<Salle?> studioList = [];
    studioList = programmes.map((toElement){
      if(toElement.sallePratique != null){
        return toElement.sallePratique?.salle;
      }
    }).toList();
    return studioList;
  }

  @override
  Widget build(BuildContext context) {
    void ChangeDate(DateTime date) {
      var currentDate = '${date.year}-${date.month}-${date.day}';
      programmeBloc.add(FetchDataEvent(filter: {'date': currentDate}));
    }

    void Filter() {
      setState(() {});
    }

    void dispose() {
      // Clean up the controller when the widget is removed from the
      // widget tree.
      designationFilter.dispose();
      super.dispose();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          automaticallyImplyLeading:
              false, // Empêche l'affichage du bouton back
          toolbarHeight: 60,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Planning',
                style: GoogleFonts.arimo(
                  color: const Color(0xff15274d),
                  fontSize: titreConstant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPushPage())),
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
                      right: 0,
                      top: -5,
                      child: Container(
                        width: spacingConstant,
                        height: spacingConstant,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.white)),
                        // constraints: const BoxConstraints(
                        //   minWidth: spacingConstant,
                        //   minHeight: spacingConstant,
                        // ),
                        child: Center(
                          child: BlocBasedWidget<List<NotificationPush>>(
                            customDataBloc: notificationPushBloc,
                            useInfiniteScroller: true,
                            customWidget: (
                              state,
                            ) {
                              Map<String, dynamic> metadata = state.metadata;
                              dynamic totalNotifs = metadata['total'];
                              print("NOTIF TOTAL ${totalNotifs}");
                              return Text(
                                "${totalNotifs}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                      ),
                    )
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
                height: spacingConstant,
              ),
              HorizontalCalendar(
                handleDate: (date) => ChangeDate(date),
              ),
              const SizedBox(
                height: spacingConstant,
              ),
              BlocBasedWidget<List<Programme>>(
                customDataBloc: programmeBloc,
                customWidget: (state) {
                  List<Programme> programmes = state.data;
                  Map<String, dynamic>? metadata = state.metadata;
                  bool canLoadNewData = state.canLoadNewData;
                  List<Salle?> studioList = extractStudiosOptions(programmes);

                  if (programmes.isEmpty) {
                    return const Center(
                        child: const Text('Aucune activité programmée'));
                  }
                  List<dynamic> dataFiltered = programmes
                      .where((element) => element
                      .professeurPratique!.pratique!.designation
                      .toString()
                      .toLowerCase()
                      .startsWith(designationFilter.text.toLowerCase()))
                      .toList();
                  if (dataFiltered.isEmpty) {
                    return const Center(
                        child: Text('Aucune activité trouvée'));
                  }
                  return Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: spacingConstant),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Inputfiled(
                                controller: designationFilter,
                                type: "text",
                                text: 'Désignation',
                                icon: 'loupe',
                                error: '',
                                handleChangeValue: (value) => Filter(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text('|'),
                            const SizedBox(width: 10),
                            Container(
                              height: 45,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: primaryColor, // Couleur de fond bleu
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icons/home2.svg",
                                      height: 15, color: Colors.white),
                                  const SizedBox(
                                      width:
                                      10.0), // Espace entre l'icône et le DropdownButton
                                  DropdownButton(
                                    dropdownColor: primaryColor, // Couleur du dropdown
                                    value: selectedValue,
                                    hint: const Text(
                                      'Studio',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: const TextStyle(
                                        color: Colors.white), // Couleur du texte
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/arrow_b.svg',
                                        color: Colors.white,
                                      ),
                                    ),
                                    underline:
                                    const SizedBox(), // Supprime la ligne par défaut
                                    items: studioList.map((Salle? salle) {
                                      return DropdownMenuItem(
                                        value: salle?.id,
                                        child: Text(
                                            "${salle?.designation}",
                                            style: const TextStyle(color: Colors.white)),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValue = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: spacingConstant,
                      ),
                      ...dataFiltered
                          .map((toElement) => CardRowPlanning(
                        data: toElement,
                      ))
                          .toList(),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: spacingConstant,
              ),

            ],
          ),
        ));
  }
}

class HorizontalCalendar extends StatefulWidget {
  final Function(DateTime date)? handleDate;
  const HorizontalCalendar({super.key, this.handleDate});

  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime selectedDate = DateTime.now();
  late List<DateTime> weekDays; // Liste des jours de la semaine courante

  @override
  void initState() {
    super.initState();
    // Générer la liste des jours de la semaine courante
    weekDays = _generateWeekDays();
  }

  // Fonction pour générer les jours restants de la semaine courante
  List<DateTime> _generateWeekDays() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday; // Jour actuel (1 = Lundi, 7 = Dimanche)

    // Créer une liste des jours à partir du jour actuel jusqu'à Dimanche
    return List.generate(7 - currentWeekday + 1, (index) {
      return now.add(Duration(days: index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Affichage du mois et de l'année (fixe, pas de navigation)
        Padding(
          padding: const EdgeInsets.only(bottom: spacingConstant),
          child: Text(
            DateFormat.yMMM('fr_FR').format(DateTime.now()).toCapitalized,
            style: TextStyle(
              fontSize: titreConstant,
              color: primaryColor,
            ),
          ),
        ),

        // Liste horizontale des jours de la semaine courante
        SizedBox(
          height: 75,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weekDays.length,
            itemBuilder: (context, index) {
              DateTime date = weekDays[index];
              bool isSelected = date.day == selectedDate.day &&
                  date.month == selectedDate.month &&
                  date.year == selectedDate.year;

              return GestureDetector(
                onTap: () {
                  widget.handleDate!(date);
                  setState(() {
                    selectedDate = date;
                  });
                },
                child: Container(
                  width: 60,
                  margin: index == 0
                      ? const EdgeInsets.only(
                          right: spacingConstant, left: spacingConstant)
                      : const EdgeInsets.only(right: spacingConstant),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xffA8923B) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : greyColor,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.E('fr_FR')
                            .format(date)
                            .toCapitalized, // Jour abrégé
                        style: TextStyle(
                          fontSize: textConstant,
                          color: isSelected ? primaryColor : greyColor,
                        ),
                      ),
                      Text(
                        date.day.toString(), // Numéro du jour
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? primaryColor : greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
