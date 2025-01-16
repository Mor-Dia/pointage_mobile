import 'package:flutter/foundation.dart';
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

class PratiquesPage extends StatefulWidget {
  final Map<String, dynamic>? constantFilter;
  final bool? hideAppBar;
  const PratiquesPage({super.key, this.hideAppBar, this.constantFilter});

  @override
  State<PratiquesPage> createState() => _PratiquesPageState();
}

class _PratiquesPageState extends State<PratiquesPage> {
  late DataBloc<List<Pratique>> practiceBloc;
  Map<String, dynamic> initialFilter = {"count": 10};
  Map<String, dynamic> currentFilter = {};
  bool hideAppBar = false;
  bool loadingNewData = false;

  ScrollController practiceListController = ScrollController();

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
    super.initState();
  }

  // getAdditionalData(){
  //   if (kDebugMode) {
  //     print("SCROLLING OFFSET: ${practiceListController.offset}, POSITION MAXCSROLL ${practiceListController.position.maxScrollExtent}, MAXSCROLL MINUS: ${practiceListController.position.maxScrollExtent-50}");
  //   }
  //   if (practiceListController.offset >= practiceListController.position.maxScrollExtent-50 &&
  //       !practiceListController.position.outOfRange) {
  //     print("SCROLLING ${practiceBloc.state is DataSuccess<List<Pratique>>}");
  //     if(practiceBloc.state is DataSuccess<List<Pratique>>){
  //       int currentPage = 1;
  //       Map<String, dynamic>? metadata = (practiceBloc.state as DataSuccess<List<Pratique>>).metadata;
  //       bool canLoadNewData = (practiceBloc.state as DataSuccess<List<Pratique>>).canLoadNewData;
  //       if(canLoadNewData){
  //         if(metadata != null && metadata.containsKey("page")){
  //           currentPage = metadata['page'];
  //         }
  //         setState((){
  //           loadingNewData = true;
  //         });
  //         practiceBloc.add(FetchDataEvent(filter: {...currentFilter, ...{"page": currentPage+1} },));
  //       }
  //     }
  //   }
  //   // practiceBloc.stream.listen(onData)
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    // practiceListController.removeListener(listener);
    super.dispose();
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
                    fontSize: titreConstant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: spacingConstant, right: spacingConstant),
        child: BlocBasedWidget<List<Pratique>>(
          customDataBloc: practiceBloc,
          filter: currentFilter,
          useInfiniteScroller: true,
          customWidget: (state) {
            List<Pratique> pratiques = state.data;
            return Column(children: [
              const SizedBox(
                height: spacingConstant,
              ),
              Wrap(spacing: 10, runSpacing: 10, children: [
                ...pratiques
                    .map((toElement) => SizedBox(
                        width: size.width /
                                (MediaQuery.of(context).size.width > 400
                                    ? 2
                                    : 2) -
                            25,
                        child: CardPratique(
                          data: toElement,
                          handlePress: () {},
                        )))
                    .toList(),
              ]),
            ]);
          },
        ),
      ),
    );
  }
}
