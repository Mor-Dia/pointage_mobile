import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';

import '../../components/card_lignecredit.dart';
import '../../components/please_login_widget.dart';
import '../../core/models/user_model.dart';
import '../../services/api/models/ligne_credit_model.dart';
import '../../services/authentication_bloc/authentication_bloc.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';

class _LigneCreditPageState extends State<LigneCreditPage> {

  late DataBloc<List<LigneCredit>> lcBloc;
  Map<String, dynamic> globalFilter = {"count": 10};
  bool hide = false;

  @override
  void initState() {
    lcBloc = DataBloc<List<LigneCredit>>(
            (response) => LigneCredit.fromJsonList(response),
        LigneCredit.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: LigneCredit.shrinkedAttributs());

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
                      // dynamic solde = authState.user?.solde;
                      dynamic solde = "15 0000";
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
                                    Text(
                                        hide? "*******" : "${solde} XOF",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold
                                        )
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
                handlerPress: () => {},
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
}

class LigneCreditPage extends StatefulWidget {
  const LigneCreditPage({super.key});

  @override
  State<LigneCreditPage> createState() => _LigneCreditPageState();
}
