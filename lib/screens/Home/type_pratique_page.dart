import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/CardTypePratique.dart';
import 'package:yogivida_mobile/constant.dart';

import 'package:yogivida_mobile/services/api/models/type_pratique_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

class TypePratiquePage extends StatefulWidget {
  final Map<String, dynamic>? constantFilter;
  const TypePratiquePage({super.key, this.constantFilter});

  @override
  State<TypePratiquePage> createState() => _PratiquesPageState();
}

class _PratiquesPageState extends State<TypePratiquePage> {
  late DataBloc<List<TypePratique>> typePracticeBloc;
  Map<String, dynamic> currentFilter = {"showatwebsite": "true", "count": 100};

  @override
  void initState() {
    typePracticeBloc = DataBloc<List<TypePratique>>(
        (response) => TypePratique.fromJsonList(response),
        TypePratique.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: TypePratique.shrinkedAttributs());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.square(kToolbarHeight),
        child: AppBar(
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          leading: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: greyColorL,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/back.svg'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pratiques',
                style: GoogleFonts.arimo(
                  color: primaryColor,
                  fontSize: titreConstant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: size.height,
        child: SingleChildScrollView(
          // Ajouter ici un SingleChildScrollView

          child: Padding(
            padding: const EdgeInsets.only(
                left: spacingConstant, right: spacingConstant),
            child: Column(
              children: [
                // Ajouter ici l'élément avant le listing des pratiques
                const SizedBox(height: spacingConstant),
                // Listing des pratiques
                BlocBasedWidget<List<TypePratique>>(
                  customDataBloc: typePracticeBloc,
                  filter: currentFilter,
                  useInfiniteScroller: true,
                  customWidget: (state) {
                    List<TypePratique> typepratiques = state.data;
                    return Column(
                      children: [
                        const SizedBox(height: spacingConstant),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: typepratiques.map((toElement) {
                            return SizedBox(
                              width: size.width /
                                      (MediaQuery.of(context).size.width > 400
                                          ? 2
                                          : 2) -
                                  25,
                              child: CardTypePratique(
                                data: toElement,
                                handlePress: () {},
                                // afterLike: () {
                                //   // Après un like, on met à jour la liste des pratiques
                                //   // updateListPratique(currentFilter);
                                // },
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: spacingConstant),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
