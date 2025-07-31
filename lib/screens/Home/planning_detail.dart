import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/CardRowPlanning.dart';
import 'package:yogivida_mobile/components/TopDialogNotification.dart';
import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/custom_error.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/no_data_widget.dart';

import '../../components/custom_cached_network_image.dart';
import '../../constant.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';

class PlanningDetail extends StatefulWidget {
  final int? programmeId;
  const PlanningDetail({
    super.key,
    required this.programmeId,
  });

  @override
  State<PlanningDetail> createState() => _PlanningDetailState();
}

class _PlanningDetailState extends State<PlanningDetail> {
  late DataBloc<List<Programme>> dataBloc;
  Map<String, dynamic> globalFilter = {"count": 10};

  @override
  void initState() {
    initFilter();
    dataBloc = DataBloc<List<Programme>>(
        (response) => Programme.fromJsonList(response),
        Programme.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Programme.shrinkedAttributs());
    super.initState();
  }

  initFilter() {
    if (widget.programmeId != null) {
      globalFilter.addAll({"id": widget.programmeId});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text(
          "Planning",
          style: GoogleFonts.arimo(
            color: const Color(0xff15274d),
            fontSize: titreConstant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBasedWidget<List<Programme>>(
        customDataBloc: dataBloc,
        filter: {...globalFilter},
        useInfiniteScroller: true,
        customWidget: (state) {
          List<Programme> data = state.data;
          if (data.isEmpty) {
            return const Center(child: Text('Aucune planning trouvée'));
          }
          Programme currentPlanning = data[0];
          return CardRowPlanning(
            data: currentPlanning,
          );
        },
        customErrorWidget: customWidget(context, "error"),
        customPendingWidget: customWidget(context, "pending"),
        customNoDataWidget: customWidget(context, "noData"),
      ),
    );
  }
}

customWidget(context, widgetType) {
  Widget widgetToDisplay =
      const Loader1(size: 8); // CircularProgressIndicator();
  if (widgetType == "error") {
    widgetToDisplay = const CustomErrorWidget();
  } else {
    widgetToDisplay = const NoDataWidget();
  }
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
            'Planning',
            style: GoogleFonts.arimo(
              color: const Color(0xff15274d),
              fontSize: titreConstant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    body: SafeArea(
      child: Center(
        child: widgetToDisplay,
      ),
    ),
  );
}
