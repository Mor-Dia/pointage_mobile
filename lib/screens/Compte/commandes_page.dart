import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/card_commande.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:yogivida_mobile/components/please_login_widget.dart';
import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

import '../../services/api/models/commande_model.dart';

class CommandesPage extends StatefulWidget {
  const CommandesPage({super.key});

  @override
  State<CommandesPage> createState() => _CommandesPageState();
}

class _CommandesPageState extends State<CommandesPage> {
  late DataBloc<List<Commande>> commandeBloc;
  Map<String, dynamic> globalFilter = {"count": 10};

  @override
  void initState() {
    commandeBloc = DataBloc<List<Commande>>(
        (response) => Commande.fromJsonList(response),
        Commande.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Commande.shrinkedAttributs());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              'Mes commandes',
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
          child: BlocBuilder<AuthenticationBloc<Utilisateur>,
              AuthenticationState<Utilisateur>>(builder: (context, authState) {
            AuthenticationStatus currentStatus = authState.status;
            int? clientId = authState.user?.id;
            switch (currentStatus) {
              case AuthenticationStatus.authenticated:
                return BlocBasedWidget<List<Commande>>(
                  customDataBloc: commandeBloc,
                  filter: {...globalFilter, "client_id": clientId},
                  useInfiniteScroller: true,
                  customWidget: (state) {
                    List<Commande> commandes = state.data;

                    if (commandes == null || commandes.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                          // Centre le texte horizontalement
                          child: Text(
                            "Vous n'avez aucune commande",
                            style: GoogleFonts.arimo(
                              color: primaryColor,
                              fontSize: titreConstant,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return Column(children: [
                      const SizedBox(
                        height: spacingConstant,
                      ),
                      ...commandes
                          .map((toElement) => CardCommande(
                                commande: toElement,
                              ))
                          .toList(),
                    ]);
                  },
                );
              case AuthenticationStatus.unknown:
              case AuthenticationStatus.unauthenticated:
              case AuthenticationStatus.failure:
                return const Center(child: PleaseLoginWidget());
            }
          })),
    );
  }
}
