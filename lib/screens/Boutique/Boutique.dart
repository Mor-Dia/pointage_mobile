import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/CardProduit.dart';
import 'package:yogivida_mobile/components/CardProduitPanier.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
import 'package:yogivida_mobile/screens/Boutique/Panier.dart';
import 'package:yogivida_mobile/services/api/models/famille_model.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';
import 'package:yogivida_mobile/services/api/models/panier_model.dart';
import 'dart:ui' as ui;

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/produit_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';
import 'package:yogivida_mobile/services/panierBloc/panier_bloc_bloc.dart';

import '../../core/utils/helpers.dart';

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
  late Map<String, dynamic> productFilter = {};
  late Map<String, dynamic> familleFilter = {};
  List<PanierPProduit>? _panier;

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  late Map<String, dynamic> minMax;
  String? token;
  String? userId;

  Future getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      userId = prefs.getString('user_id');
    });
    context.read<PanierBlocBloc>().add(PanierBlocEvent.refresh(token: token!));
  }

  @override
  void initState() {
    getCredentials();

    minMax = {
      "min": minController.text,
      "max": maxController.text,
      "isFiltering": false
    };

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

    productFilter.addAll({'count': 15, 'showatwebsite': 'true'});

    familleFilter.addAll({'showatwebsite': 'true'});
    // produitBloc.add(FetchDataEvent())

    super.initState();
  }

  void filtreFamille(index, famille_produit_id) {
    setState(() {
      selectedFamilyIndex = index; // Met à jour la famille sélectionnée
      if (famille_produit_id == null) {
        productFilter = {...productFilter..remove('famille_produit_id')};
      }
      productFilter = {
        ...productFilter..addAll({'famille_produit_id': famille_produit_id})
      };
    });
  }

  void filtreSearch() {
    print(searchController.text);
    if (searchController.text != '') {
      setState(() {
        productFilter = {
          ...productFilter..addAll({'search': searchController.text})
        };
      });
    }
  }

  void filtreMinMax(TextEditingController min, TextEditingController max) {
    setState(() {
      minMax['min'] = min.text;
      minMax['max'] = max.text;
      minMax['isFiltering'] = true;

      if (min.text != '' && int.parse(min.text.trim()) > 0) {
        productFilter = {
          ...productFilter
            ..addAll({'prix_min': int.parse(min.text), 'prix_croissant': true})
        };
      }

      if (max.text != '' && int.parse(max.text.trim()) > 0) {
        productFilter = {
          ...productFilter
            ..addAll({'prix_max': int.parse(max.text), 'prix_croissant': true})
        };
      }
    });

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void addToPanier(Map<String, dynamic> arg) async {
    arg['token'] = token;
    arg['client_id'] = userId;

    // arg['token'] = int.tryParse(userId ?? '0') ?? 0;
    // arg['client_id'] = int.tryParse(userId ?? '0') ?? 0;

    context
        .read<PanierBlocBloc>()
        .add(PanierBlocEvent.postPanier(body: arg, token: token ?? ''));
  }

  void reset(type) {
    setState(() {
      if (type == 'search') {
        productFilter = {...productFilter..remove('search')};
        searchController.text = '';
      } else if (type == 'minmax') {
        productFilter = {...productFilter..remove('prix_min')};
        productFilter = {...productFilter..remove('prix_max')};
        productFilter = {...productFilter..remove('prix_croissant')};
        minMax = {"min": '', "max": '', "isFiltering": false};
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });
  }

  void dispose() {
    minController.dispose();
    maxController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                  "Boutique",
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
                          builder: (context) => const PanierPage())),
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
                      BlocConsumer<PanierBlocBloc, PanierBlocState>(
                          listener: (context, state) {
                        if (state is PanierError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                        if (state is PanierSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.message,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green[400],
                            ),
                          );
                        }
                        if (state is PanierLoaded) {
                          _panier = state.panier.panierProduit;
                        }
                      }, builder: (context, state) {
                        return Positioned(
                          right: -5,
                          top: -5,
                          child: Container(
                            width: 25,
                            height: 25,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: secondColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1.5, color: Colors.white)),
                            constraints: const BoxConstraints(
                              minWidth: spacingConstant,
                              minHeight: spacingConstant,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                (state is PanierLoading)
                                    ? Container(
                                        width: 10,
                                        height: 10,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        (_panier?.length ?? 0).toString(),
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
                        );
                      })
                    ],
                  ),
                ),
              ],
            )),
        body: BlocBasedWidget<List<Famille>>(
            customDataBloc: familleBloc,
            filter: familleFilter,
            customWidget: (state) {
              List<Famille> marques = [];
              marques = marques..add(Famille(id: null, designation: 'Tout'));
              marques = marques..addAll(state.data);
              return Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: spacingConstant,
                    ),
                    SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Permet le défilement horizontal
                      child: Row(
                        children: marques.map((marque) {
                          int index = marques.indexOf(marque);
                          return GestureDetector(
                            onTap: () {
                              filtreFamille(index, marque.id);
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
                      height: spacingConstant,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Inputfiled(
                              type: "text",
                              controller: searchController,
                              text: 'Désignation',
                              icon: 'loupe',
                              error: '',
                              // handleChangeValue: (value) => Filter(),
                            ),
                          ),
                          SizedBox(width: searchController.text != '' ? 10 : 0),
                          searchController.text != ''
                              ? GestureDetector(
                                  onTap: () {
                                    reset('search');
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: spacingConstant,
                                    color: Colors.red,
                                  ),
                                )
                              : SizedBox.shrink(),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              filtreSearch();
                            },
                            child: Container(
                              height: 45,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                          const SizedBox(width: 10),
                          const Text('|'),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              ShowBottomSheetFiltrePrix(context, minController,
                                  maxController, filtreMinMax, handleReset: () {
                                reset('minmax');
                              });
                            },
                            child: Container(
                              height: 45,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: primaryColor, // Couleur de fond bleu
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
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
                                  minMax['isFiltering']
                                      ? Text(
                                          '${minMax['min']} - ${minMax['max']}',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : SizedBox.shrink()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: spacingConstant,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: spacingConstant),
                        child: BlocBasedWidget<List<Produit>>(
                            customDataBloc: produitBloc,
                            useInfiniteScroller: true,
                            filter: productFilter,
                            customWidget: (state) {
                              List<Produit> produits = state.data;

                              if (produits.isEmpty) {
                                return const Center(
                                    child: Text('Aucun produits trouvés'));
                              }
                              return Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 10,
                                runSpacing: 10,
                                children: produits
                                    .map((Produit toElement) => SizedBox(
                                          width: Helpers.getGridElementWidth(
                                              context, 25),
                                          child: CardProduit(
                                            data: toElement,
                                            handlePress: (value) {
                                              toElement.currentQuantity! >= 1
                                                  ? addToPanier(value)
                                                  : null;
                                            },
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

Future<dynamic> ShowBottomSheetFiltrePrix(
    BuildContext context,
    TextEditingController minController,
    TextEditingController maxController,
    Function(TextEditingController min, TextEditingController max) handlePress,
    {Function()? handleReset}) {
  void validate() {
    handlePress(minController, maxController);
  }

  void reset() {
    handleReset!();
  }

  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(spacingConstant),
                  topRight: Radius.circular(spacingConstant))),
          child: Padding(
            padding: EdgeInsets.all(spacingConstant),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 2,
                    width: 50,
                    decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(spacingConstant))),
                  ),
                ),
                SizedBox(
                  height: spacingConstant,
                ),
                Center(
                  child: Text(
                    'Filtrer par prix '.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: spacingConstant,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: spacingConstant),
                          child: TextField(
                              controller: minController,
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
                      width: spacingConstant,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: spacingConstant),
                          child: TextField(
                              controller: maxController,
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
                  height: spacingConstant,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ButtonFiled(
                        text: 'Valider',
                        handlerPress: () {
                          validate();
                        },
                      ),
                    ),
                    SizedBox(
                      width: spacingConstant,
                    ),
                    Expanded(
                      child: ButtonFiled(
                        text: 'Reinitialiser',
                        color: Colors.red,
                        handlerPress: () {
                          reset();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
