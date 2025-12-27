import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pointage_mobile/components/CardPratique.dart';
import 'package:pointage_mobile/components/CardProduit.dart';
import 'package:pointage_mobile/components/CardProduitFavoris.dart';
import 'package:pointage_mobile/components/CardProduitPanier.dart';
import 'package:pointage_mobile/components/CardRowPlanning.dart';
import 'package:pointage_mobile/components/CardRowPlanning2.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/services/api/models/favoris_model.dart';

import 'package:pointage_mobile/services/api/models/pratique_model.dart';
import 'package:pointage_mobile/services/api/models/produit_model.dart';
import 'package:pointage_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:pointage_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisState();
}

class _FavorisState extends State<FavorisPage> {
  late DataBloc<List<Produit>> favorisBloc;
  @override
  List<Pratique> listPratique = [
    // Pratique('Fly yoga', 'assets/images/pratique1.jpg', false),
    // Pratique('Fly yoga', 'assets/images/pratique2.jpg', true),
  ];

  String? token;
  String? userId;

  Future getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      userId = prefs.getString('user_id');
    });
  }

  @override
  void initState() {
    getCredentials();
    favorisBloc = DataBloc<List<Produit>>(
        (response) => Favoris.fromJsonList(response),
        Favoris.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Favoris.shrinkedAttributs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                'Mes Favoris',
                style: GoogleFonts.arimo(
                  color: primaryColor,
                  fontSize: titreConstant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: primaryColor,
                width: 1.0, // Épaisseur du trait sous l'onglet actif
              ),
              insets: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.30),
              // 0.25 sur chaque côté pour que le trait fasse 50% de la largeur de l'onglet
            ),
            indicatorColor: primaryColor,
            indicatorWeight: 1.0, // Épaisseur du trait sous l'onglet actif
            indicatorSize:
                TabBarIndicatorSize.label, // Le trait prend la largeur du texte
            labelColor: primaryColor, // Couleur du texte actif
            unselectedLabelColor: greyColor, // Couleur du texte inactif
            tabs: const [
              Tab(text: 'Pratiques'),
              Tab(text: 'Boutique'),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              ScrollableTabPage(
                data: favorisBloc,
              ),
              ScrollableTabPage2(data: favorisBloc, token: token)
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollableTabPage extends StatelessWidget {
  final DataBloc<List<Produit>> data;
  final String? token;
  const ScrollableTabPage({Key? key, required this.data, this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(spacingConstant),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [],
        ),
      ),
    );
  }
}

class ScrollableTabPage2 extends StatelessWidget {
  final DataBloc<List<Produit>> data;
  final String? token;
  const ScrollableTabPage2({Key? key, required this.data, this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBasedWidget<List<Produit>>(
        customDataBloc: data,
        filter: {"token": token, 'count': 8},
        customWidget: (state) {
          List<Produit> produits = state.data;
          print(produits);
          return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(spacingConstant),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 10,
                  children: produits
                      .map((Produit toElement) => SizedBox(
                            width: size.width / (MediaQuery.of(context).size.width > 400 ? 3  : 2) - 25,
                            child: CardProduitFavoris(
                              data: toElement,
                            ),
                          ))
                      .toList(),
                )),
          );
        });
  }
}
