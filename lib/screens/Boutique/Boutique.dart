import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/CardProduit.dart';
import 'package:yogivida_mobile/components/CardProduitPanier.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
import 'package:yogivida_mobile/screens/Boutique/Panier.dart';
import 'package:yogivida_mobile/services/api/models/famille_model.dart';
import 'dart:ui' as ui;

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/produit_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

class Boutique extends StatefulWidget {
  const Boutique({super.key});

  @override
  State<Boutique> createState() => _BoutiqueState();
}

class _BoutiqueState extends State<Boutique> {
  String? selectedValue;

  int selectedFamilyIndex = 0; // Indice de la famille sélectionnée
  late DataBloc<List<Famille>> familleBloc;
  late DataBloc<List<Produit>> produitBloc;

  @override
  void initState() {
    familleBloc = DataBloc<List<Famille>>(
        (response) => Famille.fromJsonList(response),
        Famille.getEndpoint(isPagination: false),
        isGraphQl: true,
        isPagination: false,
        attributeToGet: Famille.shrinkedAttributs());

    produitBloc = DataBloc<List<Produit>>(
        (response) => Produit.fromJsonList(response),
        Produit.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Produit.shrinkedAttributs());

    // familleBloc.add(FetchDataEvent());
    // produitBloc.add(FetchDataEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    void filtre(index, famille_produit_id) {
      setState(() {
        selectedFamilyIndex = index; // Met à jour la famille sélectionnée
        produitBloc.add(
            FetchDataEvent(filter: {'famille_produit_id': famille_produit_id}));
      });
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
                'Boutique',
                style: GoogleFonts.arimo(
                  color: const Color(0xff15274d),
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Panier())),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: secondColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/cadit.svg',
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
                            color: secondColor,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1.5, color: Colors.white)),
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
        body: BlocBasedWidget<List<Famille>>(
            customDataBloc: familleBloc,
            customWidget: (state) {
              List<Famille> marques = state.data;
              return Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Permet le défilement horizontal
                      child: Row(
                        children: marques.map((marque) {
                          int index = marques.indexOf(marque);

                          return GestureDetector(
                            onTap: () {
                              filtre(index, marque.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      16.0), // Ajoute de l'espace entre les éléments
                              child: Column(
                                mainAxisSize: MainAxisSize
                                    .min, // Prend juste l'espace nécessaire
                                children: [
                                  Text(
                                    marque.designation.toString().toCapitalized,
                                    style: TextStyle(
                                      color: selectedFamilyIndex == index
                                          ? primaryColor
                                          : greyColor, // Texte bleu pour la famille active
                                      fontWeight: selectedFamilyIndex == index
                                          ? FontWeight.bold
                                          : FontWeight
                                              .normal, // Texte en gras pour la famille active
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          4.0), // Espace entre le texte et la ligne soulignée
                                  if (selectedFamilyIndex == index)
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        // Utilise un LayoutBuilder pour obtenir la taille du texte
                                        final textPainter = TextPainter(
                                          text: TextSpan(
                                            text: marque.designation
                                                .toString()
                                                .toCapitalized,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          textDirection: ui.TextDirection
                                              .ltr, // Correction ici
                                        );
                                        textPainter.layout();
                                        return Container(
                                          height:
                                              1.0, // Hauteur de la ligne de soulignement
                                          width: textPainter
                                              .width, // Largeur égale à celle du texte
                                          color:
                                              primaryColor, // Ligne bleue sous la famille active
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Inputfiled(
                              type: "text",
                              text: 'Désignation',
                              icon: 'loupe',
                              error: '',
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('|'),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              ShowBottomSheetFiltrePrix(context);
                            },
                            child: Container(
                              height: 45,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: primaryColor, // Couleur de fond bleu
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icons/stat.svg",
                                      height: 15, color: Colors.white),
                                  const SizedBox(
                                      width:
                                          10.0), // Espace entre l'icône et le DropdownButton
                                  const Text(
                                    'Par prix',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: BlocBasedWidget<List<Produit>>(
                            customDataBloc: produitBloc,
                            useInfiniteScroller: true,
                            customWidget: (state) {
                              List<Produit> produits = state.data;
                              Map<String, dynamic>? metadata = state.metadata;
                              bool canLoadNewData = state.canLoadNewData;
                              return Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: produits
                                    .map((toElement) => SizedBox(
                                          width: size.width / 2 - 25,
                                          child: CardProduit(
                                            data: toElement,
                                            handlePress: () => {},
                                          ),
                                        ))
                                    .toList(),
                              );
                            }))
                  ],
                ),
              );
            }));
  }
}

Future<dynamic> ShowBottomSheetFiltrePrix(BuildContext context) {
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
                    'Filtrer par prix '.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                              decoration: InputDecoration(
                                  icon: Text(
                                    'Min',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                  border: InputBorder.none,
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: primaryColor))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                              decoration: InputDecoration(
                                  icon: Text(
                                    'Max',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                  border: InputBorder.none,
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: primaryColor))),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonFiled(
                  text: 'Valider',
                  handlerPress: () {},
                )
              ],
            ),
          ),
        );
      });
}
