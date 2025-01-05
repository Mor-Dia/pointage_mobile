import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/constant.dart';

import '../../components/notification_container.dart';
import '../../core/models/user_model.dart';
import '../../services/api/models/notificationpush_model.dart';
import '../../services/authentication_bloc/authentication_bloc.dart';
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

  updateList(newFilter){
    notificationPushBloc.add(FetchDataEvent(filter: newFilter));
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
        body: BlocBuilder<AuthenticationBloc<Utilisateur>, AuthenticationState<Utilisateur>>(
          builder: (context, authState) {
            AuthenticationStatus currentStatus = authState.status;
            Utilisateur? user = authState.user;
            int? currentUserId;
            if(user != null){
              currentUserId = user!.id;
            }
            switch (currentStatus) {
              case AuthenticationStatus.authenticated:
                return BlocBasedWidget<List<NotificationPush>>(
                  customDataBloc: notificationPushBloc,
                  filter: {...currentFilter, ...{"client_id": currentUserId}},
                  useInfiniteScroller: true,
                  customWidget: (state) {
                    List<NotificationPush> notificationPushs = state.data;
                    return
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          ...notificationPushs
                              .map((toElement) => NotificationContainer(
                            notificationPush: toElement,
                            updateFunction: () => updateList({...currentFilter, ...{"client_id": currentUserId}}),
                          )).toList(),
                        ]
                      );
                  },
                );
              case AuthenticationStatus.unknown:
              case AuthenticationStatus.unauthenticated:
              case AuthenticationStatus.failure:
                return const SizedBox.shrink();
            }
          }
        ));
  }
}