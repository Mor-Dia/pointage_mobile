import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogivida_mobile/services/api/models/notificationpush_model.dart';

import '../constant.dart';
import '../core/models/user_model.dart';
import '../services/authentication_bloc/authentication_bloc.dart';
import '../services/post_api_bloc.dart';
import 'animated_gesture_detector.dart';

class NotificationContainer extends StatefulWidget {
  final NotificationPush notificationPush;
  final Function? updateFunction;

  const NotificationContainer({super.key, required this.notificationPush, this.updateFunction});

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {

  bool isRead = false;
  late PostApiBloc postApiBloc;

  late NotificationPush notificationPush;
 @override
  void initState() {
    notificationPush = widget.notificationPush;
    postApiBloc = PostApiBloc();
    super.initState();
  }

  markAsRead(Map<String, dynamic> params){
    postApiBloc
        .add(PostApiMakeCall(endpoint: 'markasread', parameters: params));
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: greyColorL))
        ),
        child: Padding(
          padding: const EdgeInsets.all(spacingConstant),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${notificationPush.dateEmissionFr}",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      "${notificationPush.title}",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 3,
                      style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "${notificationPush.description}",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    )
                  ],
                ),
              ),
              BlocBuilder<AuthenticationBloc<Utilisateur>,
                  AuthenticationState<Utilisateur>>(
                  builder: (context, authState) {
                    AuthenticationStatus currentStatus = authState.status;
                    Utilisateur? user = authState.user;
                    int? currentUserId;
                    if(user != null){
                      currentUserId = user!.id;
                    }
                    switch (currentStatus) {
                      case AuthenticationStatus.authenticated:
                        return BlocConsumer(
                          bloc: postApiBloc,
                          listener: (context, state) {
                            if (state is PostApiSuccess) {
                              if(widget.updateFunction != null){
                                widget.updateFunction!();
                              }
                            }
                            if (state is PostApiProcessing) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            }
                          },
                          builder: (BuildContext context, postBlocState) {
                            return AnimatedGestureButton(
                              animate: postBlocState is PostApiProcessing,
                              child: SizedBox(
                                child: GestureDetector(
                                  onTap: (){
                                    Map<String, dynamic> params = {
                                      "client_id" : currentUserId,
                                      "notificationpush_id": notificationPush.id,
                                    };
                                    markAsRead(params);
                                  },
                                  child: Container(
                                    height: 45,
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    margin: const EdgeInsets.only(left: 2.0),
                                    decoration: BoxDecoration(
                                      color: primaryColor, // Couleur de fond bleu
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: const Icon(Icons.remove_red_eye_outlined, color: Colors.white,),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      case AuthenticationStatus.unknown:
                      case AuthenticationStatus.unauthenticated:
                      case AuthenticationStatus.failure:
                        return const Center(child: SizedBox.shrink());
                    }
                  }
                )

            ],
          ),
        ),
      );
  }
}
