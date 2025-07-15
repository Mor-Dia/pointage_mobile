import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/services/api/models/reservation_model.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/custom_error.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/no_data_widget.dart';

import '../../components/CardRowPlanning2.dart';
import '../../components/custom_cached_network_image.dart';
import '../../constant.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';

class ReservationDetail extends StatefulWidget {
  final int? reservationId;
  const ReservationDetail({
    super.key,
    required this.reservationId,
  });

  @override
  State<ReservationDetail> createState() => _ReservationDetailState();
}

class _ReservationDetailState extends State<ReservationDetail> {
  late DataBloc<List<Reservation>> dataBloc;
  Map<String, dynamic> globalFilter = {"count": 10};

  @override
  void initState() {
    initFilter();
    dataBloc = DataBloc<List<Reservation>>(
        (response) => Reservation.fromJsonList(response),
        Reservation.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Reservation.shrinkedAttributs());
    super.initState();
  }

  initFilter() {
    if (widget.reservationId != null) {
      globalFilter.addAll({"id": widget.reservationId});
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "Reservation",
          style: GoogleFonts.arimo(
            color: const Color(0xff15274d),
            fontSize: titreConstant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBasedWidget<List<Reservation>>(
        customDataBloc: dataBloc,
        filter: {...globalFilter},
        useInfiniteScroller: true,
        customWidget: (state) {
          List<Reservation> data = state.data;

          if (data.isEmpty) {
            return const Center(child: Text('Aucune réservation trouvée'));
          }
          Reservation currentReservation = data[0];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CardRowPlanning2(
                  reservation: currentReservation,
                )
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
  Widget widgetToDisplay = const Loader1(size: 8);
  // CircularProgressIndicator();
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
            'Reservation',
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
    )),
  );
}
