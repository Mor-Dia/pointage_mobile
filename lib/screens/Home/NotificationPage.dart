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

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Key _nonLuesKey = UniqueKey();
  Key _luesKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _nonLuesKey = UniqueKey();
          _luesKey = UniqueKey();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
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
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 60,
        title: Text(
          'Notifications',
          style: GoogleFonts.arimo(
            color: primaryColor,
            fontSize: titreConstant,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicator: UnderlineTabIndicator(
            borderSide: const BorderSide(color: primaryColor, width: 1.0),
            insets: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.30,
            ),
          ),
          labelColor: primaryColor,
          unselectedLabelColor: greyColor,
          tabs: const [
            Tab(text: 'Non lues'),
            Tab(text: 'Lues'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NotificationPushList(
            key: _nonLuesKey,
            basedFilter: {"is_read": false},
          ),
          NotificationPushList(
            key: _luesKey,
            basedFilter: {"is_read": true},
          ),
        ],
      ),
    );
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
  late PostApiBloc postApiBloc;
  Map<String, dynamic> currentFilter = {"count": 100};
  bool isUnReadList = false;

  @override
  void initState() {
    super.initState();
    if (widget.basedFilter != null) {
      currentFilter.addAll(widget.basedFilter!);
      if (widget.basedFilter!.containsKey("is_read") &&
          widget.basedFilter!["is_read"] == false) {
        isUnReadList = true;
      }
    }

    notificationPushBloc = DataBloc<List<NotificationPush>>(
      (response) => NotificationPush.fromJsonList(response),
      NotificationPush.getEndpoint(isPagination: true),
      isGraphQl: true,
      isPagination: true,
      attributeToGet: NotificationPush.shrinkedAttributs(),
    );

    postApiBloc = PostApiBloc();
  }

  void updateList(Map<String, dynamic> newFilter) {
    notificationPushBloc.add(FetchDataEvent(filter: newFilter));
  }

  void markAllAsRead(Map<String, dynamic> params) {
    postApiBloc.add(PostApiMakeCall(
      endpoint: 'markallasread',
      parameters: params,
    ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AuthenticationBloc<Utilisateur>,
        AuthenticationState<Utilisateur>>(
      builder: (context, authState) {
        if (authState.status != AuthenticationStatus.authenticated ||
            authState.user == null) return const SizedBox.shrink();

        final currentUserId = authState.user!.id;

        return BlocBasedWidget<List<NotificationPush>>(
          customDataBloc: notificationPushBloc,
          filter: {
            ...currentFilter,
            "client_id": currentUserId,
          },
          useInfiniteScroller: true,
          customWidget: (state) {
            final notifications = state.data;

            if (notifications.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Aucune notification disponible'),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isUnReadList)
                  Row(
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
                                "client_id": currentUserId,
                              });
                            }
                          },
                          builder: (context, postBlocState) {
                            return AnimatedGestureButton(
                              animate: postBlocState is PostApiProcessing,
                              child: GestureDetector(
                                onTap: () {
                                  markAllAsRead({"client_id": currentUserId});
                                },
                                child: Container(
                                  height: 45,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: const Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ...notifications.map(
                  (notif) => NotificationContainer(
                    notificationPush: notif,
                    updateFunction: () => updateList({
                      ...currentFilter,
                      "client_id": currentUserId,
                    }),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
