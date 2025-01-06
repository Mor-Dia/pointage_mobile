import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';

import '../../components/InputFiled.dart';
import '../../components/animated_gesture_detector.dart';
import '../../components/card_lignecredit.dart';
import '../../components/please_login_widget.dart';
import '../../components/type_paiement_card.dart';
import '../../core/models/user_model.dart';
import '../../core/utils/helpers.dart';
import '../../services/api/models/ligne_credit_model.dart';
import '../../services/api/models/type_paiement_model.dart';
import '../../services/authentication_bloc/authentication_bloc.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';
import '../../services/post_api_bloc.dart';

class _LigneCreditPageState extends State<LigneCreditPage> {

  late DataBloc<List<LigneCredit>> lcBloc;
  late DataBloc<List<Utilisateur>> utilisateurBloc;
  Map<String, dynamic> globalFilter = {"count": 10};
  bool hide = false;
  TextEditingController montantController = TextEditingController();
  String? currentError;

  @override
  void initState() {
    lcBloc = DataBloc<List<LigneCredit>>(
            (response) => LigneCredit.fromJsonList(response),
        LigneCredit.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: LigneCredit.shrinkedAttributs());

    utilisateurBloc = DataBloc<List<Utilisateur>>(
            (response) => Utilisateur.fromJsonList(response),
        Utilisateur.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Utilisateur.shrinkedAttributs());

    super.initState();
  }

  hideAndShowBalance(){
    setState(() {
      hide = !hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Mes lignes crédits',
              style: GoogleFonts.arimo(
                color: const Color(0xff15274d),
                fontSize: titreConstant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: spacingConstant),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacingConstant),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: greyColor),
                    borderRadius: BorderRadius.circular(8)),
                child: BlocBuilder<AuthenticationBloc<Utilisateur>, AuthenticationState<Utilisateur>>(
                    builder: (context, authState) {
                      AuthenticationStatus currentStatus = authState.status;
                      Utilisateur? currentUser = authState.user;
                      switch(currentStatus){
                        case AuthenticationStatus.authenticated:
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        'Solde',
                                        style: TextStyle(fontSize: 13, color: primaryColor)
                                    ),
                                    BlocBasedWidget<List<Utilisateur>>(
                                      customDataBloc: utilisateurBloc,
                                      filter: {"id": currentUser?.id},
                                      customWidget: (state) {
                                        List<Utilisateur> users = state.data;
                                        Utilisateur currentClient = users[0];
                                        return
                                        Text(
                                          hide? "*******" : "${Helpers.formatNumber(currentClient.solde)} XOF",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: hideAndShowBalance,
                                  icon: Icon(
                                    hide ? Icons.visibility_off : Icons.remove_red_eye,
                                    size: spacingConstant,
                                    color: const Color(0xff15274d),
                                  ),
                                ),
                              ],
                            ),
                          );
                        case AuthenticationStatus.unknown:
                        case AuthenticationStatus.unauthenticated:
                        case AuthenticationStatus.failure:
                          return const Center(child: PleaseLoginWidget());
                      }
                    }
                ),
              ),
            ),
            const SizedBox(
              height: spacingConstant,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacingConstant),
              child: ButtonFiled(
                text: 'Approvisionner le compte',
                handlerPress: () => {ShowBottomSheetPayment(context)},
              ),
            ),
            const SizedBox(
              height: spacingConstant,
            ),
            Expanded(
              child: BlocBuilder<AuthenticationBloc<Utilisateur>, AuthenticationState<Utilisateur>>(
                  builder: (context, authState) {
                    AuthenticationStatus currentStatus = authState.status;
                    int? clientId = authState.user?.id;
                    switch(currentStatus){
                      case AuthenticationStatus.authenticated:
                        return BlocBasedWidget<List<LigneCredit>>(
                          customDataBloc: lcBloc,
                          filter: {...globalFilter, "client_id":clientId  },
                          useInfiniteScroller: true,
                          customWidget: (state) {
                            List<LigneCredit> lcs = state.data;
                            return Column(
                                children:  [
                                  const SizedBox(
                                    height: spacingConstant,
                                  ),
                                  ...lcs
                                      .map((toElement) => CardLignecredit(ligneCredit: toElement,))
                                      .toList(),
                                ]
                            );
                          },
                        );
                      case AuthenticationStatus.unknown:
                      case AuthenticationStatus.unauthenticated:
                      case AuthenticationStatus.failure:
                        return const Center(child: PleaseLoginWidget());
                    }
                  }
              )
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowBottomSheetPayment(BuildContext context, {Function? customFunction}) {
    DataBloc<List<TypePaiement>> typePaiementPushBloc = DataBloc<List<TypePaiement>>(
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
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(spacingConstant), topRight: Radius.circular(spacingConstant))),
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
                              borderRadius: BorderRadius.all(Radius.circular(spacingConstant))),
                        ),
                      ),
                      const SizedBox(
                        height: spacingConstant,
                      ),
                      Inputfiled(
                        type: 'number',
                        text: "Montant",
                        controller: montantController,
                        error: currentError, // L'erreur est vide au départ
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
                      BlocBasedWidget<List<TypePaiement>>(
                        customDataBloc: typePaiementPushBloc,
                        // filter: currentFilter,
                        useInfiniteScroller: true,
                        customWidget: (state) {
                          List<TypePaiement> typePaiements = state.data;
                          return
                            Column(
                                children:  [
                                  const SizedBox(
                                    height: spacingConstant,
                                  ),
                                  Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        ...buildTypePaiementList(currentContext, typePaiements, montantController.text),
                                      ]
                                  ),
                                ]
                            );
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

  List<Widget> buildTypePaiementList(BuildContext parentContext, List<TypePaiement> typePaiements, montant){
    late PostApiBloc reservationPostBloc;
    reservationPostBloc = PostApiBloc();

    reserverCours({required Map<String, dynamic> parameters}) {
      reservationPostBloc.add(PostApiMakeCall(endpoint: 'lignecredit', parameters: parameters));
    }

    return [
      ...typePaiements.map((toElement) {
        return BlocBuilder<AuthenticationBloc<Utilisateur>,
            AuthenticationState<Utilisateur>>(
            builder: (context, authState) {
              AuthenticationStatus currentStatus = authState.status;
              Utilisateur? user = authState.user;
              switch (currentStatus) {
                case AuthenticationStatus.authenticated:
                  return BlocConsumer(
                    bloc: reservationPostBloc,
                    listener: (context, state) {
                      if (state is PostApiSuccess) {
                        ScaffoldMessenger.of(parentContext).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${state.message}",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green[400],
                          ),
                        );
                      }
                      if (state is PostApiFailure) {
                        print("NEW STATE ${state.message}");
                        ScaffoldMessenger.of(parentContext).hideCurrentSnackBar();
                        ScaffoldMessenger.of(parentContext).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${state.message}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (BuildContext context, postBlocState) {
                      return AnimatedGestureButton(
                        animate: postBlocState is PostApiProcessing,
                        child: GestureDetector(
                            onTap: (){
                              Map<String, dynamic> parameters = {
                                "montant": montant,
                                "client": user?.id,
                                "from_site": true,
                                "typelignecredit" : 2,
                                "type_paiement": toElement.id,
                              };
                              reserverCours(parameters: parameters);
                            },
                            child: TypePaiementCard(typePaiement: toElement)
                        ),
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

class LigneCreditPage extends StatefulWidget {
  const LigneCreditPage({super.key});

  @override
  State<LigneCreditPage> createState() => _LigneCreditPageState();
}
