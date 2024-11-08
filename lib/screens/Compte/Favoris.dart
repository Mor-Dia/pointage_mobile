import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/CardPratique.dart';
import 'package:yogivida_mobile/components/CardProduit.dart';
import 'package:yogivida_mobile/components/CardProduitPanier.dart';
import 'package:yogivida_mobile/components/CardRowPlanning.dart';
import 'package:yogivida_mobile/components/CardRowPlanning2.dart';
import 'package:yogivida_mobile/constant.dart';

class Favoris extends StatefulWidget {
  const Favoris({super.key});

  @override
  State<Favoris> createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> {
  @override
  List<Pratique> listPratique = [
    Pratique('Fly yoga', 'assets/images/pratique1.jpg', false),
    Pratique('Fly yoga', 'assets/images/pratique2.jpg', true),
  ];
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
                  fontSize: MediaQuery.of(context).size.width * 0.055,
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
                data: listPratique,
              ),
              ScrollableTabPage2(data: listPratique)
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollableTabPage extends StatelessWidget {
  final List<Pratique> data;
  const ScrollableTabPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: data
              .map((toElement) => SizedBox(
                  width: size.width / 2 - 25,
                  child: CardPratique(
                    data: toElement,
                    handlePress: () => null,
                  )))
              .toList(),
        ),
      ),
    );
  }
}

class ScrollableTabPage2 extends StatelessWidget {
  final List<Pratique> data;

  const ScrollableTabPage2({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: data
              .map((toElement) => SizedBox(
                    width: size.width / 2 - 25,
                    child: CardProduit(
                      data: toElement,
                      handlePress: () => {},
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
