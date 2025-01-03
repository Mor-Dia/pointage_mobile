import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/constant.dart';

import '../../components/notification_container.dart';
import '../../services/api/models/notificationpush_model.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';



class NotificationPushPage extends StatefulWidget {
  const NotificationPushPage({super.key});

  @override
  State<NotificationPushPage> createState() => _NotificationPushPageState();
}

class _NotificationPushPageState extends State<NotificationPushPage> {

  late DataBloc<List<NotificationPush>> notificationPushBloc;
  Map<String, dynamic> initialFilter = {"count": 10};
  Map<String, dynamic> currentFilter = {};

  @override
  void initState() {
    currentFilter.addAll({...initialFilter});
    notificationPushBloc = DataBloc<List<NotificationPush>>(
            (response) => NotificationPush.fromJsonList(response),
        NotificationPush.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: NotificationPush.shrinkedAttributs());
    super.initState();
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications',
                style: GoogleFonts.arimo(
                  color: primaryColor,
                  fontSize: titreConstant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Container(
            color: Colors.white,
            child: BlocBasedWidget<List<NotificationPush>>(
              customDataBloc: notificationPushBloc,
              filter: currentFilter,
              useInfiniteScroller: true,
              customWidget: (state) {
                List<NotificationPush> notificationPushs = state.data;
                return
                  Column(
                      children:  [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...notificationPushs
                                .map((toElement) => NotificationContainer(notificationPush: toElement))
                                .toList(),
                          ]
                        ),
                      ]
                  );
              },
            )
        ));
  }
}