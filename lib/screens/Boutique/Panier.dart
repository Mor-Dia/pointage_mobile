import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/CardProduitPanier.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/panierBloc/panier_bloc_bloc.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({super.key});

  @override
  State<PanierPage> createState() => _PanierState();
}

class _PanierState extends State<PanierPage> {
  List<PanierPProduit>? _panier;

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
                  if (state is PanierLoaded) {
                    _panier = state.panier.panierProduit;
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
                      Text(
                        (state is PanierLoaded)
                          ? 'TOTAL TTC : ${state.panier.total}'
                          : '0',
                        style: const TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: titreConstant),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: spacingConstant),
                        child: ButtonFiled(text: 'FINALISER LA COMMANDE', handlerPress: () {
                          
                        },),
                      ),
                      const SizedBox(height: 40)
                    ],
                  );
                })));
  }
}
