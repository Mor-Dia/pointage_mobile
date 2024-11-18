import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/CardPratique.dart';
import 'package:yogivida_mobile/components/CardProduit.dart';
import 'package:yogivida_mobile/constant.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc_helpers.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

class Pratiques extends StatefulWidget {
  const Pratiques({super.key});

  @override
  State<Pratiques> createState() => _PratiquesState();
}

class _PratiquesState extends State<Pratiques> {
  late DataBloc<List<Pratique>> practiceBloc;

  @override
  void initState() {
    practiceBloc = DataBloc<List<Pratique>>(
        (response) => Pratique.fromJsonList(response),
        Pratique.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Pratique.shrinkedAttributs());

    practiceBloc.add(FetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pratiques',
                style: GoogleFonts.arimo(
                  color: primaryColor,
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: BlocBasedWidget<List<Pratique>>(
              customDataBloc: practiceBloc,
              customWidget: (data) {
                print("DATA BLOC BASED DATA $data");
                List<Pratique> pratiques = data;
                return ListView(scrollDirection: Axis.vertical, children: [
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: pratiques
                        .map((toElement) => SizedBox(
                            width: size.width / 2 - 25,
                            child: CardPratique(
                              data: toElement,
                              handlePress: () => ShowBottomSheet(context),
                            )))
                        .toList(),
                  ),
                ]
                    // child: Row(
                    //   children: [
                    //     ...pratiques
                    //         .map((toElement) => Row(
                    //               children: [
                    //                 const SizedBox(
                    //                   width: 20,
                    //                 ),
                    //                 CardPratique(
                    //                   data: toElement,
                    //                   handlePress: () => ShowBottomSheet(context),
                    //                 )
                    //               ],
                    //             ))
                    //         .toList(),
                    //     const SizedBox(
                    //       width: 20,
                    //     ),
                    //   ],
                    // ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> ShowBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [Text("hello")],
          ),
        );
      });
}
