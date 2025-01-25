import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/constant.dart';

import '../../components/animated_gesture_detector.dart';
import '../../components/notification_container.dart';
import '../../core/models/user_model.dart';
import '../../services/api/models/notificationpush_model.dart';
import '../../services/authentication_bloc/authentication_bloc.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';
import '../../services/post_api_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
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
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.0, // Épaisseur du trait sous l'onglet actif
                ),
                insets: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.30),
                // 0.25 sur chaque côté pour que le trait fasse 50% de la largeur de l'onglet
              ),
              indicatorColor: primaryColor,
              indicatorWeight: 1.0, // Épaisseur du trait sous l'onglet actif
              indicatorSize: TabBarIndicatorSize
                  .label, // Le trait prend la largeur du texte
              labelColor: primaryColor, // Couleur du texte actif
              unselectedLabelColor: greyColor, // Couleur du texte inactif
              tabs: const [
                Tab(text: 'Non lues'),
                Tab(text: 'Lues'),
              ],
            ),
          ),
          body: Container(
            color: Colors.white,
            child: const TabBarView(
              children: [
                NotificationPushList(
                  basedFilter: {"is_read": false},
                ),
                NotificationPushList(
                  basedFilter: {"is_read": true},
                )
              ],
            ),
          ),
        ));
  }
}

class NotificationPushList extends StatefulWidget {
  final Map<String, dynamic>? basedFilter;
  const NotificationPushList({super.key, this.basedFilter});

  @override
  State<NotificationPushList> createState() => _NotificationPushListState();
}

class _NotificationPushListState extends State<NotificationPushList>
    with AutomaticKeepAliveClientMixin {
  late DataBloc<List<NotificationPush>> notificationPushBloc;
  Map<String, dynamic> initialFilter = {"count": 10};
  Map<String, dynamic> currentFilter = {};
  late PostApiBloc postApiBloc;
  bool isUnReadList = false;

  @override
  void initState() {
    currentFilter.addAll({
      ...initialFilter,
    });
    if (widget.basedFilter != null) {
      currentFilter.addAll({...?widget.basedFilter});
      if (widget.basedFilter!.containsKey("is_read") &&
          !widget.basedFilter!["is_read"]) {
        isUnReadList = true;
      }
    }
    notificationPushBloc = DataBloc<List<NotificationPush>>(
        (response) => NotificationPush.fromJsonList(response),
        NotificationPush.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: NotificationPush.shrinkedAttributs());
    postApiBloc = PostApiBloc();
    super.initState();
  }

  updateList(newFilter) {
    notificationPushBloc.add(FetchDataEvent(filter: newFilter));
  }

  markAllAsRead(Map<String, dynamic> params) {
    postApiBloc
        .add(PostApiMakeCall(endpoint: 'markallasread', parameters: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AuthenticationBloc<Utilisateur>,
            AuthenticationState<Utilisateur>>(builder: (context, authState) {
          AuthenticationStatus currentStatus = authState.status;
          Utilisateur? user = authState.user;
          int? currentUserId;
          if (user != null) {
            currentUserId = user!.id;
          }
          switch (currentStatus) {
            case AuthenticationStatus.authenticated:
              return BlocBasedWidget<List<NotificationPush>>(
                customDataBloc: notificationPushBloc,
                filter: {
                  ...currentFilter,
                  ...{"client_id": currentUserId}
                },
                useInfiniteScroller: true,
                customWidget: (state) {
                  List<NotificationPush> notificationPushs = state.data;

                  if (notificationPushs.isEmpty) {
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: const Center(
                        child: Text('Aucune notification disponible'),
                      ),
                    );
                  }

                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: isUnReadList,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(spacingConstant),
                                child: BlocConsumer(
                                  bloc: postApiBloc,
                                  listener: (context, state) {
                                    if (state is PostApiSuccess) {
                                      updateList({
                                        ...currentFilter,
                                        ...{"client_id": currentUserId}
                                      });
                                    }
                                    if (state is PostApiProcessing) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    }
                                  },
                                  builder:
                                      (BuildContext context, postBlocState) {
                                    return AnimatedGestureButton(
                                      animate:
                                          postBlocState is PostApiProcessing,
                                      child: SizedBox(
                                        child: GestureDetector(
                                          onTap: () {
                                            Map<String, dynamic> params = {
                                              "client_id": currentUserId,
                                            };
                                            markAllAsRead(params);
                                          },
                                          child: Container(
                                            height: 45,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            margin: const EdgeInsets.only(
                                                left: 2.0),
                                            decoration: BoxDecoration(
                                              color:
                                                  primaryColor, // Couleur de fond bleu
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: const Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...notificationPushs
                            .map((toElement) => NotificationContainer(
                                  notificationPush: toElement,
                                  updateFunction: () => updateList({
                                    ...currentFilter,
                                    ...{"client_id": currentUserId}
                                  }),
                                ))
                            .toList(),
                      ]);
                },
              );
            case AuthenticationStatus.unknown:
            case AuthenticationStatus.unauthenticated:
            case AuthenticationStatus.failure:
              return const SizedBox.shrink();
          }
        }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
