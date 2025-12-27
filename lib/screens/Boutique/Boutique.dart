import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pointage_mobile/components/ButtonField.dart';
import 'package:pointage_mobile/components/CardProduit.dart';
import 'package:pointage_mobile/components/InputFiled.dart';
import 'package:pointage_mobile/components/TopDialogNotification.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/core/models/user_model.dart';
import 'package:pointage_mobile/core/utils/Capitalized.dart';
import 'package:pointage_mobile/screens/Boutique/Panier.dart';
import 'package:pointage_mobile/services/api/models/famille_model.dart';
import 'package:pointage_mobile/services/api/models/panierProduit_model.dart';
import 'dart:ui' as ui;

import 'package:pointage_mobile/services/api/models/produit_model.dart';
import 'package:pointage_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:pointage_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:pointage_mobile/services/data_bloc/presentation/bloc_based_widget.dart';
import 'package:pointage_mobile/services/panierBloc/panier_bloc_bloc.dart';

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

  late ScrollController _searchProductScrollControler = ScrollController();

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
    if (token == null) {
      context.read<PanierBlocBloc>().add(PanierBlocEvent.refresh(token: ''));
    } else {
      context
          .read<PanierBlocBloc>()
          .add(PanierBlocEvent.refresh(token: token!));
    }
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

    productFilter.addAll({'count': 100, 'showatwebsite': 'true', 'is_front': true});
    familleFilter.addAll({'showatwebsite': 'true'});

    _searchProductScrollControler = ScrollController();
    _searchProductScrollControler.addListener(_onScrollProduct);

    super.initState();
  }

  void _onScrollProduct() {}

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

    context
        .read<PanierBlocBloc>()
        .add(PanierBlocEvent.postPanier(body: arg, token: token ?? ''));
  }

  void reset(type) {
    setState(() {
      switch (type) {
        case 'search':
          productFilter.remove('search');
          searchController.clear();
          break;

        case 'minmax':
          productFilter.removeWhere((key, _) =>
              key == 'prix_min' ||
              key == 'prix_max' ||
              key == 'prix_croissant');

          minMax = {"min": '', "max": '', "isFiltering": true};

          // vider les champs min et max
          minController.clear();
          maxController.clear();

          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          break;
      }
    });

    produitBloc
        .add(FetchDataEvent(filter: {'count': 100, 'showatwebsite': 'true', 'is_front': true}));
  }

  void dispose() {
    minController.dispose();
    maxController.dispose();
    searchController.dispose();

    _searchProductScrollControler
        .dispose(); // important si tu as un ScrollController

    super.dispose();
  }

  // ✅ Accès à toutes les variables ici !
  Widget _buildFiltresBar() {
    return Padding(
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
            ),
          ),
          if (searchController.text.isNotEmpty) ...[
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => reset('search'),
              child:
                  Icon(Icons.cancel, size: spacingConstant, color: Colors.red),
            ),
          ],
          const SizedBox(width: 10),
          GestureDetector(
            onTap: filtreSearch,
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: primaryColor,
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
            onTap: () => ShowBottomSheetFiltrePrix(
              context,
              minController,
              maxController,
              filtreMinMax,
              handleReset: () => reset('minmax'),
            ),
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: primaryColor,
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
                      const SizedBox(width: 10),
                      const Text('Par prix',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  if (minMax['isFiltering'])
                    Text('${minMax['min']} - ${minMax['max']}',
                        style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamillesList(List<Famille> familles) {
    final List<Famille> famille = [
      Famille(id: null, designation: 'Tout'),
      ...familles
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: famille.map((marque) {
          int index = famille.indexOf(marque);
          final isSelected = selectedFamilyIndex == index;

          return GestureDetector(
            onTap: () => filtreFamille(index, marque.id),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    marque.designation?.toCapitalized ?? '',
                    style: TextStyle(
                      color: isSelected ? primaryColor : greyColor,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  if (isSelected)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final textPainter = TextPainter(
                          text: TextSpan(
                            text: marque.designation?.toCapitalized ?? '',
                            style: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                          textDirection: ui.TextDirection.ltr,
                        );
                        textPainter.layout();
                        return Container(
                          height: 1.0,
                          width: textPainter.width,
                          color: primaryColor,
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var authBloc = context.read<AuthenticationBloc<Utilisateur>>();
    Utilisateur? user = authBloc.state.user;

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
                if (user != null)
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
                            TopDialogNotification.show(context,
                                message: state.message, isError: true);
                          }
                          if (state is PanierSuccess) {
                            TopDialogNotification.show(context,
                                message: state.message, isError: false);
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
                                          child: Loader1(size: 8))
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
            List<Famille> familles = [];
            familles = familles..add(Famille(id: null, designation: 'Tout'));
            familles = familles..addAll(state.data);

            return Container(
              color: Colors.white,
              child: ListView(
                controller:
                    _searchProductScrollControler, // 👈 scroll controller ici
                children: [
                  const SizedBox(height: spacingConstant),
                  _buildFamillesList(state.data),
                  const SizedBox(height: spacingConstant),
                  _buildFiltresBar(),
                  const SizedBox(height: spacingConstant),

                  /// BlocBasedWidget Produits sans SingleChildScrollView
                  BlocBasedWidget<List<Produit>>(
                    customDataBloc: produitBloc,
                    useInfiniteScroller: true,
                    filter: productFilter,
                    customWidget: (state) {
                      List<Produit> produits = state.data;

                      if (produits.isEmpty) {
                        return const Center(
                            child: Text('Aucun produits trouvés'));
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: spacingConstant),
                        child: Wrap(
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ));
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
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.35,
          child: Container(
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(spacingConstant))),
                    ),
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  Center(
                    child: Text(
                      'Filtrer par prix '.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // autorise seulement les chiffres
                                ],
                                decoration: const InputDecoration(
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
                      const SizedBox(
                        width: spacingConstant,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spacingConstant),
                            child: TextField(
                                controller: maxController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // autorise seulement les chiffres
                                ],
                                decoration: const InputDecoration(
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
                  const SizedBox(
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
                      const SizedBox(
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
          ),
        );
      });
}
