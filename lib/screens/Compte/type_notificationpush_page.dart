import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/CardTypeNotificationPush.dart';
import 'package:yogivida_mobile/components/CardProduit.dart';
import 'package:yogivida_mobile/constant.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc_helpers.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

import '../../core/models/user_model.dart';
import '../../services/api/models/type_notificationpush_model.dart';
import '../../services/authentication_bloc/authentication_bloc.dart';
import '../../services/post_api_bloc.dart';

class TypeNotificationPushsPage extends StatefulWidget {
  final Map<String, dynamic>? constantFilter;
  final bool? hideAppBar;
  const TypeNotificationPushsPage({super.key, this.hideAppBar, this.constantFilter});

  @override
  State<TypeNotificationPushsPage> createState() => _TypeNotificationPushsPageState();
}

class _TypeNotificationPushsPageState extends State<TypeNotificationPushsPage> {
  late DataBloc<List<TypeNotificationPush>> typeNotificationBloc;
  late PostApiBloc saveTNPPostBloc;
  Map<String, dynamic> initialFilter = {"count": 10};
  Map<String, dynamic> currentFilter = {};
  bool hideAppBar = false;
  bool loadingNewData = false;
  bool isApiProcessing = false;
  List<int> selectedTNPIds = [];

  ScrollController practiceListController = ScrollController();

  @override
  void initState() {
    saveTNPPostBloc = PostApiBloc();
    currentFilter.addAll({...initialFilter});
    if(widget.constantFilter != null){
      currentFilter.addAll({...?widget.constantFilter});
    }
    hideAppBar = widget.hideAppBar??false;
    typeNotificationBloc = DataBloc<List<TypeNotificationPush>>(
        (response) => TypeNotificationPush.fromJsonList(response),
        TypeNotificationPush.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: TypeNotificationPush.shrinkedAttributs());
    super.initState();
  }

  saveTNPPreferences(){
    AuthenticationBloc currentAuthBloc = BlocProvider.of<AuthenticationBloc<Utilisateur>>(context);
    AuthenticationStatus currentStatus = currentAuthBloc.state.status;
    switch (currentStatus) {
      case AuthenticationStatus.unknown:
      case AuthenticationStatus.unauthenticated:
      case AuthenticationStatus.failure:
        break;
      case AuthenticationStatus.authenticated:
        Utilisateur currentUser = currentAuthBloc.state.user;
        int? currentUserId = currentUser.id;
        // setState(() {
        //   isApiProcessing = true;
        // });
        Map<String, dynamic>parameters = {"ids": selectedTNPIds, "client_id": currentUserId};
        saveTNPPostBloc.add(PostApiMakeCall(endpoint: 'settnppreferences', parameters: parameters));
    }


  }

  addTNP(value){
    setState(() {
      selectedTNPIds.add(value);
    });
    print("NEW TNPLIST VAL $selectedTNPIds");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.square(kToolbarHeight),
        child: Visibility(
          visible: true,
          child: AppBar(
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
            title: Text(
              'Types de notification',
              style: GoogleFonts.arimo(
                color: primaryColor,
                fontSize: titreConstant,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              BlocConsumer(
                bloc: saveTNPPostBloc,
                listener: (context, state) {
                  if (state is PostApiSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green[400],
                      ),
                    );
                  }
                  if (state is PostApiFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Une erreur est survenue',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red[400],
                      ),
                    );
                  }
                  if (state is PostApiProcessing) {
                    setState(() {
                      isApiProcessing = true;
                    });
                  }
                },
                builder: (BuildContext context, postBlocState) {
                  return IconButton(
                      onPressed: saveTNPPreferences,
                      icon: const Icon(Icons.check)
                  );
                },
              )
            ],
          ),
        ),
      ),
      body: AbsorbPointer(
        absorbing: isApiProcessing,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: isApiProcessing,
                child: Container(
                  color: Colors.black87.withOpacity(0.5),
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: spacingConstant, right: spacingConstant),
                child: BlocBasedWidget<List<TypeNotificationPush>>(
                  customDataBloc: typeNotificationBloc,
                  filter: currentFilter,
                  useInfiniteScroller: true,
                  customWidget: (state) {
                    List<TypeNotificationPush> tnps = state.data;
                    return
                      Column(
                          children:  [
                            ...tnps
                                .map((toElement) => CardTypeNotificationPush(
                              tnp: toElement,
                              onTNPChecked: (value) {addTNP(value);},
                            )).toList(),
                          ]
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}