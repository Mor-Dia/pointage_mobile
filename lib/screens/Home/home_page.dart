import 'package:authentication_repository/authentication_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/CardActivite.dart';
import 'package:yogivida_mobile/components/CardPratique.dart';
import 'package:yogivida_mobile/components/TopDialogNotification.dart';
import 'package:yogivida_mobile/components/custom_cached_network_image.dart';
import 'package:yogivida_mobile/components/type_paiement_card.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
import 'package:yogivida_mobile/core/utils/helpers.dart';
import 'package:yogivida_mobile/screens/Home/NotificationPage.dart';
import 'package:yogivida_mobile/screens/Home/pratique_page.dart';
import 'package:yogivida_mobile/services/api/models/banniere_model.dart';
import 'package:yogivida_mobile/services/api/models/type_pratique_model.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc_helpers.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';

import '../../components/animated_gesture_detector.dart';
import '../../core/models/user_model.dart';
import '../../services/api/models/notificationpush_model.dart';
import '../../services/api/models/programme_model.dart';
import '../../services/api/models/type_paiement_model.dart';
import '../../services/authentication_bloc/authentication_bloc.dart';
import '../../services/post_api_bloc.dart';

import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DataBloc<List<Pratique>> practiceBloc;
  late DataBloc<List<TypePratique>> typePracticeBloc;
  late DataBloc<List<Banniere>> banniereBloc;
  late DataBloc<List<Programme>> programmeBloc;
  late DataBloc<List<NotificationPush>> notificationPushBloc;
  Map<String, dynamic> globalFilter = {"count": 5};
  final DateTime date = DateTime.now();
  bool canBeDisplay = false;
  Map<String, dynamic> programmeBlocFilter = {"is_front": true};
  Map<String, dynamic> typePracticeBlocFilter = {"showatwebsite": "true"};
  Map<String, dynamic> practiceBlocFilter = {"showatwebsite": true};
  Map<String, dynamic> banniereBlocFilter = {"statut": "true"};
  Map<String, dynamic> notificationPushBlocFilter = {
    "count": 100,
    "is_read": false
  };
  dynamic currentElt;

  int selectedTypePratiqueIndex = 0;

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

    notificationPushBloc = DataBloc<List<NotificationPush>>(
        (response) => NotificationPush.fromJsonList(response),
        NotificationPush.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: NotificationPush.shrinkedAttributs());

    banniereBloc = DataBloc<List<Banniere>>(
        (response) => Banniere.fromJsonList(response),
        Banniere.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Banniere.shrinkedAttributs());

    typePracticeBloc = DataBloc<List<TypePratique>>(
        (response) => TypePratique.fromJsonList(response),
        TypePratique.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: TypePratique.shrinkedAttributs());

    initFilter();
    initNotif();
    super.initState();
  }

  initFilter() {
    // programmeBlocFilter = {'date': '${date.year}-${date.month}-${date.day}'};
    programmeBlocFilter = {
      ...programmeBlocFilter
        ..addAll({'date': '${date.year}-${date.month}-${date.day}'})
    };
  }

  void filtreTypePratique(index, type_pratique_id) {
    setState(() {
      selectedTypePratiqueIndex = index;
      print("type_pratique_id $type_pratique_id");
      if (type_pratique_id == null) {
        practiceBlocFilter = {
          ...practiceBlocFilter..remove('type_pratique_id')
        };
      }
      practiceBlocFilter = {
        ...practiceBlocFilter..addAll({'type_pratique_id': type_pratique_id})
      };
    });
  }

  initNotif() {
    int? currentUserId;

    AuthenticationBloc currentAuthBloc =
        BlocProvider.of<AuthenticationBloc<Utilisateur>>(context);
    AuthenticationStatus currentStatus = currentAuthBloc.state.status;
    switch (currentStatus) {
      case AuthenticationStatus.unknown:
      case AuthenticationStatus.unauthenticated:
      case AuthenticationStatus.failure:
        print("UPDATE USER LISTENING FAILURE 3");

        break;
      case AuthenticationStatus.authenticated:
        print("UPDATE USER LISTENING AUTH 4");

        Utilisateur currentUser = currentAuthBloc.state.user;
        currentUserId = currentUser.id;
        notificationPushBlocFilter = {
          "client_id": currentUserId,
          "is_read": false
        };
        notificationPushBloc
            .add(RefreshDataEvent(filter: notificationPushBlocFilter));
        print(
            "Refreshing typePracticeBlocFilter with filter: $notificationPushBlocFilter");
    }
  }

  @override
  Widget build(BuildContext context) {
    Utilisateur? user =
        context.read<AuthenticationBloc<Utilisateur>>().state.user;

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
            if (user != null)
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
                            child: BlocBasedWidget<List<NotificationPush>>(
                          customDataBloc: notificationPushBloc,
                          // filter: globalFilter, // Optionnel si nécessaire
                          filter: {
                            "client_id": user.id, // Filtrage par userid
                            "count": 100,
                            "is_read": false,
                          },
                          useInfiniteScroller: true,
                          customWidget: (state) {
                            Map<String, dynamic> metadata = state.metadata;
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
                        )),
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
        child: RefreshIndicator(
          onRefresh: () async {
            initFilter();
            initNotif();
            programmeBloc.add(RefreshDataEvent(filter: programmeBlocFilter));
            practiceBloc.add(RefreshDataEvent());
            banniereBloc.add(RefreshDataEvent(filter: banniereBlocFilter));
            await Future.delayed(const Duration(seconds: 1));
          },
          child: ListView(
            children: [
              const SizedBox(
                height: spacingConstant,
              ),
              BlocBasedWidget<List<Banniere>>(
                customDataBloc: banniereBloc,
                filter: banniereBlocFilter,
                customWidget: (state) {
                  List<Banniere> bannieres = state.data;

                  if (bannieres.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: spacingConstant),
                        child: Text(
                          "Évènement(s) à venir...",
                          style: GoogleFonts.montserrat(
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: spacingConstant),
                      bannieres.length == 1
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      spacingConstant), // Ajout du padding
                              width: double.infinity,
                              height: 200,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: CustomCachedNetworkImage(
                                imageUrl: bannieres[0].image ?? '',
                                // fallBackAsset: 'assets/images/home.png',
                                // fit: BoxFit.cover,
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var toElement in bannieres) ...[
                                    const SizedBox(width: spacingConstant),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .70,
                                      height: 200,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: CustomCachedNetworkImage(
                                        imageUrl: toElement.image ?? '',
                                        // fallBackAsset: 'assets/images/home.png',
                                      ),
                                    ),
                                  ],
                                  const SizedBox(width: spacingConstant),
                                ],
                              ),
                            ),
                      const SizedBox(height: spacingConstant),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: spacingConstant,
              ),
              BlocBasedWidget<List<Programme>>(
                customDataBloc: programmeBloc,
                filter: programmeBlocFilter,
                customWidget: (state) {
                  List<Programme> programmes = state.data;
                  if (programmes.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: spacingConstant, right: spacingConstant),
                        child: Text(
                          "Votre activité du jour",
                          style: GoogleFonts.montserrat(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: spacingConstant,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...programmes
                                .map((toElement) => Row(
                                      children: [
                                        const SizedBox(
                                          width: spacingConstant,
                                        ),
                                        Cardactivite(
                                            data: toElement,
                                            color: toElement.fileAttenteColor ??
                                                "",
                                            handlePress: () {
                                              if (user == null) {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                                TopDialogNotification.show(
                                                    context,
                                                    message:
                                                        "Veuillez vous connecter !",
                                                    isError: true);
                                                return; // Arrêter l'exécution si l'utilisateur n'est pas connecté
                                              }

                                              showBottomSheet(
                                                  context, toElement);
                                            })
                                      ],
                                    ))
                                .toList(),
                            const SizedBox(
                              width: spacingConstant,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: spacingConstant,
              ),
              BlocBasedWidget<List<TypePratique>>(
                  customDataBloc: typePracticeBloc,
                  filter: typePracticeBlocFilter,
                  customWidget: (state) {
                    List<TypePratique> typepratiques = [];
                    typepratiques = typepratiques
                      ..add(TypePratique(id: null, designation: "Tous"));
                    typepratiques = typepratiques..addAll(state.data);
                    print("state.data => ${state.data}");
                    print(
                        "Refreshing typePracticeBlocFilter with filter: $typePracticeBlocFilter");
                    const SizedBox(
                      height: spacingConstant,
                    );
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: spacingConstant),
                          ...typepratiques.map((toElement) {
                            int index = typepratiques
                                .indexOf(toElement); // obtenir l'index actuel
                            bool isSelected = selectedTypePratiqueIndex ==
                                index; // vérifier si l'élément est sélectionné

                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Appeler ta fonction filtreTypePratique avec l'index et le ID
                                    filtreTypePratique(index, toElement.id);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? primaryColor
                                          : Colors.transparent, // badge color
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.white
                                            : primaryColor, // bordure colorée, dépend de la sélection
                                        width: 1, // largeur de la bordure
                                      ),
                                    ),
                                    child: Text(
                                      toElement.designation
                                              .toString()
                                              .toCapitalized ??
                                          "",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors
                                                .black, // texte blanc si sélectionné
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: spacingConstant / 2),
                              ],
                            );
                          }).toList(),
                          const SizedBox(width: spacingConstant),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: spacingConstant,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: spacingConstant, right: spacingConstant),
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
                        child: const Icon(
                          Icons.arrow_outward_rounded,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: spacingConstant,
              ),
              BlocBasedWidget<List<Pratique>>(
                customDataBloc: practiceBloc,
                filter: practiceBlocFilter,
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
                                      width: spacingConstant,
                                    ),
                                    CardPratique(
                                      data: toElement,
                                      handlePress: () {},
                                      afterLike: () {
                                        print("HELLO");
                                      },
                                    )
                                  ],
                                ))
                            .toList(),
                        const SizedBox(
                          width: spacingConstant,
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheet(BuildContext context, Programme programme) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(spacingConstant),
                    topRight: Radius.circular(spacingConstant))),
            child: Padding(
              padding: const EdgeInsets.all(spacingConstant),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 2,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(spacingConstant))),
                    ),
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${programme.professeurPratique?.pratique?.designation.toString().toCapitalized}",
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "${programme.fileAttenteDisplay}",
                        style: const TextStyle(color: primaryColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/heure.svg",
                        height: 15,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${programme.heureDebut}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                      Text(
                        " - ${programme.heureFin}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(
                        "assets/icons/lc.svg",
                        height: 15,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${Helpers.formatNumber(programme.professeurPratique?.pratique?.prixSeance)} XOF",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5DFC5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
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
                                const Text(
                                  "Durée",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${programme.duration}",
                                  style: const TextStyle(
                                      color: Color(0xff838282), fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox.square(
                          dimension: 10,
                        ),
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5DFC5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      "assets/icons/person.svg",
                                      height: 15,
                                      color: const Color(0xFFA8923B),
                                    ))),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Professeur",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${programme.professeurPratique?.professeur?.user?.name.toString().toCapitalized}",
                                  style: const TextStyle(
                                      color: Color(0xff838282), fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox.square(
                          dimension: 10,
                        ),
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5DFC5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      "assets/icons/home2.svg",
                                      height: 15,
                                      color: const Color(0xFFA8923B),
                                    ))),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Salle",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${programme.sallePratique?.salle?.designation.toString().toCapitalized}",
                                  style: const TextStyle(
                                      color: Color(0xff838282), fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  Center(
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.50),
                      child: programme.fileAttente.toString() == 'true'
                          ? ButtonFiled(
                              text: 'Réserver',
                              handlerPress: () =>
                                  ShowBottomSheetPayment(context, programme),
                            )
                          :
                          // Sinon, afficher un bouton gris avec "Plein"
                          ButtonFiled(
                              text: 'Plein',
                              handlerPress: () {}, // Aucun action ici
                              color: Colors.grey,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> ShowBottomSheetPayment(
      BuildContext context, Programme programme,
      {Function? customFunction}) {
    DataBloc<List<TypePaiement>> typePaiementPushBloc =
        DataBloc<List<TypePaiement>>(
            (response) => TypePaiement.fromJsonList(response),
            TypePaiement.getEndpoint(isPagination: false),
            isGraphQl: true,
            isPagination: false,
            attributeToGet: TypePaiement.shrinkedAttributs());

    return showModalBottomSheet(
        context: context,
        builder: (BuildContext currentContext) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(spacingConstant),
                      topRight: Radius.circular(spacingConstant))),
              child: Padding(
                padding: const EdgeInsets.all(spacingConstant),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 2,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(spacingConstant))),
                        ),
                      ),
                      const SizedBox(
                        height: spacingConstant,
                      ),
                      Center(
                        child: Text(
                          'Payer par '.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: spacingConstant,
                      ),
                      Center(
                        child: Text(
                          "Montant : ${Helpers.formatNumber(programme.professeurPratique?.pratique?.prixSeance)} XOF",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      BlocBasedWidget<List<TypePaiement>>(
                        customDataBloc: typePaiementPushBloc,
                        filter: const {'showatwebsite': 'true'},
                        customWidget: (state) {
                          List<TypePaiement> typePaiements = state.data;
                          return Column(children: [
                            const SizedBox(
                              height: spacingConstant,
                            ),
                            Wrap(spacing: 10, runSpacing: 10, children: [
                              ...buildTypePaiementList(
                                  currentContext, typePaiements, programme),
                            ]),
                          ]);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<Widget> buildTypePaiementList(BuildContext parentContext,
      List<TypePaiement> typePaiements, Programme programme) {
    late PostApiBloc reservationPostBloc;
    reservationPostBloc = PostApiBloc();

    // print("HOHOHGL ${currentElt}");

    reserverCours({required Map<String, dynamic> parameters}) {
      reservationPostBloc.add(
          PostApiMakeCall(endpoint: 'reservation', parameters: parameters));
    }

    return [
      ...typePaiements.map((toElement) {
        return BlocBuilder<AuthenticationBloc<Utilisateur>,
            AuthenticationState<Utilisateur>>(builder: (context, authState) {
          AuthenticationStatus currentStatus = authState.status;
          Utilisateur? user = authState.user;
          switch (currentStatus) {
            case AuthenticationStatus.authenticated:
              return BlocConsumer(
                bloc: reservationPostBloc,
                listener: (context, state) {
                  print("MESSAGE RESE ${currentElt} ");
                  if (currentElt == toElement.id) {
                    if (state is PostApiSuccess) {
                      Navigator.of(parentContext).pop();
                      Navigator.of(context).pop();
                      if (state.data != null && state.data["url"] != null) {
                        launchUrl(Uri.parse(state.data["url"].toString()));
                      } else {
                        TopDialogNotification.show(context,
                            message: "${state.message}", isError: false);
                      }
                    }
                    if (state is PostApiFailure) {
                      print("MESSAGE RESE ${state.message} ");
                      ScaffoldMessenger.of(parentContext).hideCurrentSnackBar();
                      TopDialogNotification.show(context,
                          message: "${state.message}", isError: true);
                    }
                  }
                },
                builder: (BuildContext context, postBlocState) {
                  return AnimatedGestureButton(
                    animate: currentElt == toElement.id &&
                        postBlocState is PostApiProcessing,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentElt = null;
                            currentElt = toElement.id;
                            print(currentElt);
                          });
                          Map<String, dynamic> parameters = {
                            "programme": programme.id,
                            "client": user?.id,
                            "from_site": true,
                            "mode_paiement_id": toElement.id,
                          };
                          reserverCours(parameters: parameters);
                        },
                        child: TypePaiementCard(typePaiement: toElement)),
                  );
                },
              );
            case AuthenticationStatus.unknown:
            case AuthenticationStatus.unauthenticated:
            case AuthenticationStatus.failure:
              return const SizedBox();
          }
        });
      }).toList(),
    ];
  }
}
