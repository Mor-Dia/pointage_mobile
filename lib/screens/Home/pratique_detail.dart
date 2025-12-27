import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointage_mobile/services/api/models/pratique_model.dart';
import 'package:pointage_mobile/services/data_bloc/presentation/custom_error.dart';
import 'package:pointage_mobile/services/data_bloc/presentation/no_data_widget.dart';

import '../../components/custom_cached_network_image.dart';
import '../../constant.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';

class PratiqueDetail extends StatefulWidget {
  final int? pratiqueId;
  const PratiqueDetail({
    super.key,
    required this.pratiqueId,
  });

  @override
  State<PratiqueDetail> createState() => _PratiqueDetailState();
}

class _PratiqueDetailState extends State<PratiqueDetail> {
  late DataBloc<List<Pratique>> dataBloc;
  Map<String, dynamic> globalFilter = {"count": 10};

  @override
  void initState() {
    initFilter();
    dataBloc = DataBloc<List<Pratique>>(
        (response) => Pratique.fromJsonList(response),
        Pratique.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Pratique.shrinkedAttributs());
    super.initState();
  }

  initFilter() {
    if (widget.pratiqueId != null) {
      globalFilter.addAll({"id": widget.pratiqueId});
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
          "Pratique",
          style: GoogleFonts.arimo(
            color: const Color(0xff15274d),
            fontSize: titreConstant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBasedWidget<List<Pratique>>(
        customDataBloc: dataBloc,
        filter: {...globalFilter},
        useInfiniteScroller: true,
        customWidget: (state) {
          List<Pratique> data = state.data;
          if (data.isEmpty) {
            return const Center(child: Text('Aucune pratique trouvée'));
          }
          Pratique currentPratique = data[0];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${currentPratique.designation}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 20),
                ),
                const SizedBox(height: 10),
                CustomCachedNetworkImage(
                    imageUrl: currentPratique.image ?? '',
                    fallBackAsset: 'assets/images/pratique_fallback.png'),
                const SizedBox(height: 10),
                Text(
                    "${currentPratique.description != null ? currentPratique.description.toString() : ""}"),
              ],
            ),
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
            'Pratique',
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
