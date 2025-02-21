import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/CardProduitPanier.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/panierBloc/panier_bloc_bloc.dart';
import 'package:yogivida_mobile/components/please_login_widget.dart';

import '../../core/utils/helpers.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({super.key});

  @override
  State<PanierPage> createState() => _PanierState();
}

class _PanierState extends State<PanierPage> {
  List<PanierPProduit>? _panier;

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthenticationBloc<Utilisateur>>();
    Utilisateur? user = authBloc.state.user;

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
                'Mon panier',
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
            child: BlocConsumer<PanierBlocBloc, PanierBlocState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (user == null) {
                    return const PleaseLoginWidget();
                  }

                  if (state is PanierLoaded) {
                    _panier = state.panier.panierProduit;
                  }

                  if (_panier == null || _panier!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        // Centre le texte horizontalement
                        child: Text(
                          'Votre panier est vide.',
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

                  return Column(
                    children: [
                      Stack(children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: ((state is PanierLoaded)
                                    ? state.panier.panierProduit!
                                    : _panier!)
                                .map((toElement) =>
                                    CardProduitPanier(data: toElement))
                                .toList(),
                          ),
                        ),
                        (state is PanierLoading)
                            ? Positioned(
                                child: Opacity(
                                opacity: .7,
                                child: Container(
                                    color: Colors.white,
                                    child: const Center(
                                        child: CircularProgressIndicator())),
                              ))
                            : const SizedBox.shrink()
                      ]),
                      const Spacer(),
                      if ((state is PanierLoaded) &&
                          state.panier.total != 0) ...[
                        Text(
                          'TOTAL TTC : ${Helpers.formatNumber(state.panier.total)}',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: titreConstant,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: spacingConstant),
                          child: ButtonFiled(
                            text: 'FINALISER LA COMMANDE',
                            handlerPress: () {
                              // Logique du bouton pour finaliser la commande
                            },
                          ),
                        ),
                      ],
                      const SizedBox(height: 40)
                    ],
                  );
                })));
  }
}
