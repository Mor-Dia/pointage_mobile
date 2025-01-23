import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/CardPratique.dart';
import 'package:yogivida_mobile/components/CardProduit.dart';
import 'package:yogivida_mobile/constant.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/type_pratique_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc_helpers.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

class PratiquesPage extends StatefulWidget {
  final Map<String, dynamic>? constantFilter;
  final bool? hideAppBar;
  const PratiquesPage({super.key, this.hideAppBar, this.constantFilter});

  @override
  State<PratiquesPage> createState() => _PratiquesPageState();
}

class _PratiquesPageState extends State<PratiquesPage> {
  late DataBloc<List<Pratique>> practiceBloc;
  Map<String, dynamic> initialFilter = {"count": 100};
  Map<String, dynamic> currentFilter = {"showatwebsite": true};
  bool hideAppBar = false;
  bool loadingNewData = false;
  late DataBloc<List<TypePratique>> typePracticeBloc;

  Map<String, dynamic> typePracticeBlocFilter = {"showatwebsite": "true"};

  ScrollController practiceListController = ScrollController();

  int selectedTypePratiqueIndex = 0;

  @override
  void initState() {
    currentFilter.addAll({...initialFilter});
    if (widget.constantFilter != null) {
      currentFilter.addAll({...?widget.constantFilter});
    }
    hideAppBar = widget.hideAppBar ?? false;
    practiceBloc = DataBloc<List<Pratique>>(
        (response) => Pratique.fromJsonList(response),
        Pratique.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Pratique.shrinkedAttributs());

    typePracticeBloc = DataBloc<List<TypePratique>>(
        (response) => TypePratique.fromJsonList(response),
        TypePratique.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: TypePratique.shrinkedAttributs());
    super.initState();
  }

  updateListPratique(newFilter) {
    print("UPDATE PRATIQUE ");
    practiceBloc.add(FetchDataEvent(filter: newFilter));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void filtreTypePratique(index, type_pratique_id) {
    setState(() {
      selectedTypePratiqueIndex = index;
      print("type_pratique_id $type_pratique_id");
      if (type_pratique_id == null) {
        currentFilter = {...currentFilter..remove('type_pratique_id')};
      }
      currentFilter = {
        ...currentFilter..addAll({'type_pratique_id': type_pratique_id})
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.square(kToolbarHeight),
        child: Visibility(
          visible: !hideAppBar,
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
                BlocBasedWidget<List<TypePratique>>(
                  customDataBloc: typePracticeBloc,
                  filter: typePracticeBlocFilter,
                  customWidget: (state) {
                    List<TypePratique> typepratiques = [];
                    typepratiques = typepratiques
                      ..add(TypePratique(id: null, designation: "Tous"));
                    typepratiques = typepratiques..addAll(state.data);

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // const SizedBox(width: spacingConstant),
                          ...typepratiques.map((toElement) {
                            int index = typepratiques.indexOf(toElement);
                            bool isSelected =
                                selectedTypePratiqueIndex == index;

                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    filtreTypePratique(index, toElement.id);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.white
                                            : primaryColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      toElement.designation?.toString() ?? "",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: spacingConstant / 2),
                              ],
                            );
                          }).toList(),
                          // const SizedBox(width: spacingConstant),
                        ],
                      ),
                    );
                  },
                ),

                // Listing des pratiques
                BlocBasedWidget<List<Pratique>>(
                  customDataBloc: practiceBloc,
                  filter: currentFilter,
                  useInfiniteScroller: true,
                  customWidget: (state) {
                    List<Pratique> pratiques = state.data;
                    return Column(
                      children: [
                        const SizedBox(height: spacingConstant),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: pratiques.map((toElement) {
                            return SizedBox(
                              width: size.width /
                                      (MediaQuery.of(context).size.width > 400
                                          ? 2
                                          : 2) -
                                  25,
                              child: CardPratique(
                                data: toElement,
                                handlePress: () {},
                                afterLike: () {
                                  // Après un like, on met à jour la liste des pratiques
                                  updateListPratique(currentFilter);
                                },
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
