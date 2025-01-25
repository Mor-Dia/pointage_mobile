import 'package:authentication_repository/authentication_repository.dart';
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
import 'package:yogivida_mobile/services/api/models/studio_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

import '../../services/api/models/notificationpush_model.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/user_model.dart';
import '../../services/authentication_bloc/authentication_bloc.dart';

class Planning extends StatefulWidget {
  final int id;

  Planning({Key? key, required this.id}) : super(key: key);

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  var selectedValue;
  Map<String, dynamic> currentFilter = {};
  late DataBloc<List<Programme>> programmeBloc;
  late DataBloc<List<Salle>> salleBloc;
  late DataBloc<List<Studio>> studioBloc;
  Map<String, dynamic> studioBlocFilter = {"showatwebsite": "true"};

  final List<String> options = [];
  TextEditingController designationFilter = TextEditingController();
  late DataBloc<List<NotificationPush>> notificationPushBloc;
  DateTime selectedDate = DateTime.now();
  final DateTime date = DateTime.now();
  // int id = 0;
  // List<Salle?> studioList = [];
  List<Studio?> studioList = [];

  @override
  void initState() {
    programmeBloc = DataBloc<List<Programme>>(
        (response) => Programme.fromJsonList(response),
        Programme.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Programme.shrinkedAttributs());

    salleBloc = DataBloc<List<Salle>>(
        (response) => Salle.fromJsonList(response),
        Salle.getEndpoint(isPagination: false),
        isGraphQl: true,
        isPagination: false,
        attributeToGet: Salle.shrinkedAttributs());

    studioBloc = DataBloc<List<Studio>>(
        (response) => Studio.fromJsonList(response),
        Studio.getEndpoint(isPagination: false),
        isGraphQl: true,
        isPagination: false,
        attributeToGet: Studio.shrinkedAttributs());

    notificationPushBloc = DataBloc<List<NotificationPush>>(
        (response) => NotificationPush.fromJsonList(response),
        NotificationPush.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: NotificationPush.shrinkedAttributs());

    initFilter();
    super.initState();
  }

  initFilter() {
    print("INIT FILTER papa" + widget.id.toString());
    currentFilter = {'date': '${date.year}-${date.month}-${date.day}'};
    if (widget.id != 0) {
      currentFilter = {
        ...currentFilter,
        'pratique_id': int.parse(widget.id.toString()),
      };
    }
  }

  selectStudio(dynamic newValue) {
    print("SELECTION FF $newValue");
    setState(() {
      currentFilter = {
        ...currentFilter,
        ...{'studio_id': newValue}
        // ...{'salle_id': newValue}
      };
      if (widget.id != 0) {
        currentFilter = {
          ...currentFilter,
          'pratique_id': int.parse(widget.id.toString()),
        };
      }
    });
  }

  void changeDate(DateTime date) {
    setState(() {
      selectedDate = date;
      currentFilter = {
        'date': "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"
      };
      if (widget.id != 0) {
        currentFilter = {
          ...currentFilter,
          'pratique_id': int.parse(widget.id.toString()),
        };
      }
    });
    // var currentDate = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';

    // programmeBloc.add(FetchDataEvent(filter: {'date': currentDate}));
  }

  void cleanFieldAndUpdateList() {
    designationFilter.clear();
    setState(() {
      selectedDate = date;
      currentFilter = {...currentFilter..remove('nom_pratique')};
      if (widget.id != 0) {
        currentFilter = {
          ...currentFilter,
          'pratique_id': int.parse(widget.id.toString()),
        };
      }
    });
  }

  void searchWithDesignation() {
    String text = designationFilter.text;
    setState(() {
      selectedDate = date;
      currentFilter = {
        ...currentFilter..addAll({'nom_pratique': text})
      };
      if (widget.id != 0) {
        currentFilter = {
          ...currentFilter,
          'pratique_id': int.parse(widget.id.toString()),
        };
      }
    });
  }

  void Filter() {
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    designationFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          automaticallyImplyLeading: widget.id == 0
              ? false
              : true, // Empêche l'affichage du bouton back
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
                        builder: (context) => const NotificationPage())),
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
                          child: BlocBuilder<AuthenticationBloc<Utilisateur>,
                              AuthenticationState<Utilisateur>>(
                            builder: (context, authState) {
                              // Vérifiez si l'utilisateur est authentifié
                              if (authState.status ==
                                  AuthenticationStatus.authenticated) {
                                // Utilisateur connecté
                                Utilisateur? user = authState.user;
                                print("Utilisateur connecté papa");
                                final userId = user?.id;

                                return BlocBasedWidget<List<NotificationPush>>(
                                  customDataBloc: notificationPushBloc,
                                  // filter: globalFilter, // Optionnel si nécessaire
                                  filter: {
                                    "client_id": userId, // Filtrage par user_id
                                    "count": 100,
                                    "is_read": false,
                                  },
                                  useInfiniteScroller: true,
                                  customWidget: (state) {
                                    Map<String, dynamic> metadata =
                                        state.metadata;
                                    dynamic totalNotifs = metadata['total'];
                                    return Text(
                                      "${totalNotifs}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                );
                              } else {
                                // Utilisateur non authentifié
                                return const Text(
                                  "0",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                );
                              }
                            },
                          ),
                        ),

                        // child: BlocBasedWidget<List<NotificationPush>>(
                        //   customDataBloc: notificationPushBloc,
                        //   // filter: globalFilter,
                        //   useInfiniteScroller: true,
                        //   customWidget: (
                        //     state,
                        //   ) {
                        //     Map<String, dynamic> metadata = state.metadata;
                        //     dynamic totalNotifs = metadata['total'];
                        //     // dynamic totalNotifs = 0;
                        //     print("NOTIF TOTAL ${totalNotifs}");
                        //     return Text(
                        //       "${totalNotifs}",
                        //       style: const TextStyle(
                        //         color: Colors.white,
                        //         // overflow: TextOverflow.ellipsis,
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //       textAlign: TextAlign.center,
                        //     );
                        //   },
                        // ),
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
                height: spacingConstant,
              ),
              HorizontalCalendar(
                selectedDate: selectedDate,
                handleDate: (date) => changeDate(date),
              ),
              const SizedBox(
                height: spacingConstant,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: spacingConstant),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Inputfiled(
                        controller: designationFilter,
                        type: "text",
                        text: 'Désignation',
                        icon: 'loupe',
                        error: '',
                      ),
                    ),
                    SizedBox.square(
                      child: GestureDetector(
                        onTap: () {
                          searchWithDesignation();
                        },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          margin: const EdgeInsets.only(left: 2.0),
                          decoration: BoxDecoration(
                            color: primaryColor, // Couleur de fond bleu
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SvgPicture.asset(
                            color: Colors.white,
                            'assets/icons/loupe.svg',
                            fit: BoxFit.scaleDown,
                            height: spacingConstant,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: designationFilter.text.isNotEmpty,
                      child: SizedBox.square(
                        dimension: 50,
                        child: GestureDetector(
                          onTap: () {
                            cleanFieldAndUpdateList();
                          },
                          child: const Icon(
                            Icons.cancel,
                            size: spacingConstant,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox.square(
                      dimension: 2,
                    ),
                    // const Spacer(),
                    // // const Text('|'),
                    // const Spacer(),
                    // Flexible(
                    //   flex: 1,
                    //   child: BlocBasedWidget<List<Salle>>(
                    //     customDataBloc: salleBloc,
                    //     customWidget: (state) {
                    //       List<Salle> salles = state.data;
                    //       return StudioSelect(
                    //         studioList: salles,
                    //         onSelect: selectStudio,
                    //       );
                    //     },
                    //   ),
                    // ),
                    Flexible(
                      flex: 1,
                      child: BlocBasedWidget<List<Studio>>(
                        customDataBloc: studioBloc,
                        filter: studioBlocFilter,
                        customWidget: (state) {
                          List<Studio> studios = [];
                          studios = studios
                            ..add(Studio(id: null, designation: "Studios"));
                          studios = studios..addAll(state.data);

                          print("STUDIOS ${studios}");
                          return StudioSelect(
                            studioList: studios,
                            onSelect: selectStudio,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: spacingConstant,
              ),
              BlocBasedWidget<List<Programme>>(
                customDataBloc: programmeBloc,
                filter: {...currentFilter},
                customWidget: (state) {
                  List<Programme> programmes = state.data;
                  Map<String, dynamic>? metadata = state.metadata;
                  // extractStudiosOptions(programmes);
                  if (programmes.isEmpty) {
                    return const Center(
                        child: const Text('Aucune activité programmée'));
                  }
                  return Column(
                    children: [
                      ...programmes
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
  final DateTime? selectedDate;
  const HorizontalCalendar({super.key, this.handleDate, this.selectedDate});

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
    if (widget.selectedDate != null) {
      selectedDate = DateTime.now();
    }
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
            style: const TextStyle(
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

class StudioSelect extends StatefulWidget {
  // final List<Salle?> studioList;
  final List<Studio?> studioList;
  final Function? onSelect;
  const StudioSelect({super.key, required this.studioList, this.onSelect});

  @override
  State<StudioSelect> createState() => _StudioSelectState();
}

class _StudioSelectState extends State<StudioSelect> {
  // List<Salle?> studioList = [];
  List<Studio?> studioList = [];
  Function? onSelect;
  dynamic selectedValue;

  @override
  void initState() {
    studioList = widget.studioList;
    onSelect = widget.onSelect;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: primaryColor, // Couleur de fond bleu
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/home2.svg",
              height: 15, color: Colors.white),
          const SizedBox(
              width: 5.0), // Espace entre l'icône et le DropdownButton
          DropdownButton(
            dropdownColor: primaryColor, // Couleur du dropdown
            value: selectedValue,
            hint: const Text(
              'Studio',
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: const TextStyle(color: Colors.white), // Couleur du texte
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            underline: const SizedBox(), // Supprime la ligne par défaut
            items: [
              ...studioList.map((Studio? studio) {
                return DropdownMenuItem(
                  value: studio?.id,
                  child: Text("${studio?.designation}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              // ...studioList.map((Studio? toElement) {
              //   return DropdownMenuItem(
              //     value: toElement?.id, // accédez à l'id comme clé dans la map
              //     child: Text(
              //       "${toElement?.designation}", // accédez à la désignation comme clé dans la map
              //       overflow: TextOverflow.ellipsis,
              //       style: const TextStyle(color: Colors.white),
              //     ),
              //   );
              // }).toList(),
            ],
            onChanged: (newValue) {
              print("SELECTION $newValue ${onSelect != null}");
              setState(() {
                selectedValue = newValue;
              });
              if (onSelect != null) {
                onSelect!(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
