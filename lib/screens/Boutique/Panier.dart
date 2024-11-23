import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/components/CardPratique.dart';
import 'package:yogivida_mobile/components/CardProduitPanier.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/models/panier_model.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  late Map<String, dynamic> productFilter = {};
  late DataBloc<List<PanierP>> panierBloc;
  String? token;

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    print(prefs.getString('token'));
  }

  @override
  void initState() {
    getToken();

    panierBloc = DataBloc<List<PanierP>>(
        (response) => PanierP.fromJsonList(response),
        PanierP.getEndpoint(isPagination: false),
        isGraphQl: true,
        isPagination: false,
        attributeToGet: PanierP.shrinkedAttributs());

    productFilter.addAll({'count': 15});

    // familleBloc.add(FetchDataEvent());
    // produitBloc.add(FetchDataEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Pratique> listPratique = [];
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
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Container(
            color: Colors.white,
            child: BlocBasedWidget<List<PanierP>>(
                customDataBloc: panierBloc,
                filter: {"token": token},
                customWidget: (state) {
                  List<PanierP> panier = state.data;

                  return ListView(
                    children: panier[0]
                        .panierProduit!
                        .map((toElement) => CardProduitPanier(data: toElement))
                        .toList(),
                  );
                })));
  }
}
