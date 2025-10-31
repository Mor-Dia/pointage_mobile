import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/TopDialogNotification.dart';
import 'package:yogivida_mobile/components/custom_cached_network_image.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
import 'package:yogivida_mobile/screens/Planning/Planning.dart';
import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';

import '../core/models/user_model.dart';
import '../services/authentication_bloc/authentication_bloc.dart';
import '../services/post_api_bloc.dart';
import 'animated_gesture_detector.dart';

class CardPratique extends StatefulWidget {
  final Pratique data;
  final Function afterLike;
  final Function? handlePress;
  final Map<String, dynamic>? filter;

  const CardPratique({
    super.key,
    this.filter,
    required this.data,
    required this.afterLike,
    this.handlePress,
  });

  @override
  State<CardPratique> createState() => _CardPratiqueState();
}

class _CardPratiqueState extends State<CardPratique> {
  late PostApiBloc favorisPostBloc;
  DataBloc? parentDataBloc;
  bool? liked;
  Function? afterLike;

  @override
  void initState() {
    favorisPostBloc = PostApiBloc();
    liked = widget.data.favoris;
    afterLike = widget.afterLike;
    super.initState();
  }

  likePratique({required Map<String, dynamic> parameters}) {
    favorisPostBloc.add(
        PostApiMakeCall(endpoint: 'pratique_favoris', parameters: parameters));
  }

  initParentDataBloc() {
    parentDataBloc = BlocProvider.of<DataBloc<List<Pratique>>>(context);
  }

  changeStateFavoris() {
    setState(() {
      liked = !liked!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onTap: () {
          ShowBottomSheetPratique(context, widget.data);
        },
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          width: MediaQuery.of(context).size.width * 0.60,
          height: 160,
          // height: 180,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: primaryColor.withOpacity(.2)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Stack(
                  children: [
                    CustomCachedNetworkImage(
                      imageUrl: widget.data.image ?? '',
                      fallBackAsset: 'assets/images/pratique_fallback.png',
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.4), // Ajuste l’opacité
                    ),
                  ],
                ),
              ),

              // Bouton favoris en haut à droite
              Positioned(
                top: 10,
                right: 10,
                child: BlocBuilder<AuthenticationBloc<Utilisateur>,
                    AuthenticationState<Utilisateur>>(
                  builder: (context, authState) {
                    AuthenticationStatus currentStatus = authState.status;
                    Utilisateur? user = authState.user;
                    switch (currentStatus) {
                      case AuthenticationStatus.authenticated:
                        return BlocConsumer(
                          bloc: favorisPostBloc,
                          listener: (context, state) {
                            if (state is PostApiSuccess) {
                              changeStateFavoris();
                              TopDialogNotification.show(context,
                                  message: liked!
                                      ? 'Ajouter au favoris'
                                      : 'Retirer des favoris',
                                  isError: false);
                              if (afterLike != null) {
                                afterLike!();
                              }
                            }
                          },
                          builder: (BuildContext context, postBlocState) {
                            return GestureDetector(
                              onTap: () {
                                Map<String, dynamic> parameters = {
                                  "token": user?.token ?? "",
                                  "pratique_id": widget.data.id,
                                  "etat": liked,
                                };
                                likePratique(parameters: parameters);
                              },
                              child: Icon(
                                liked! ? Icons.favorite : Icons.favorite_outline,
                                color: liked! ? Colors.red : Colors.white,
                                size: 28,
                              ),
                            );
                          },
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),

              // Titre en bas à gauche
              Positioned(
                left: 12,
                bottom: 12,
                right: 12,
                child: Text(
                  widget.data.designation.toString().toUpperCase() ?? '',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.arimo(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        offset: const Offset(0, 1),
                        blurRadius: 3,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );


    // Container(
    //   constraints: const BoxConstraints(maxWidth: 300),
    //   width: MediaQuery.of(context).size.width * 0.60,
    //   decoration: BoxDecoration(
    //       border: Border.all(width: 1, color: primaryColor.withOpacity(.2)),
    //       borderRadius: BorderRadius.circular(15)),
    //   child: Padding(
    //     padding: const EdgeInsets.all(spacingConstant),
    //     child: Column(
    //       children: [
    //         Row(
    //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Expanded(
    //               child: Text(
    //                 widget.data.designation.toString().toCapitalized ?? '',
    //                 softWrap: true,
    //                 maxLines: 1,
    //                 overflow: TextOverflow.ellipsis,
    //                 style: GoogleFonts.arimo(
    //                     fontSize: textConstant, fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             BlocBuilder<AuthenticationBloc<Utilisateur>,
    //                     AuthenticationState<Utilisateur>>(
    //                 builder: (context, authState) {
    //               AuthenticationStatus currentStatus = authState.status;
    //               Utilisateur? user = authState.user;
    //               switch (currentStatus) {
    //                 case AuthenticationStatus.authenticated:
    //                   return BlocConsumer(
    //                     bloc: favorisPostBloc,
    //                     listener: (context, state) {
    //                       if (state is PostApiSuccess) {
    //                         changeStateFavoris();
    //                         TopDialogNotification.show(context,
    //                             message: liked!
    //                                 ? 'Ajouter au favoris'
    //                                 : 'Retirer des favoris',
    //                             isError: false);
    //                         if (afterLike != null) {
    //                           afterLike!();
    //                         }
    //                       }
    //                       if (state is PostApiProcessing) {
    //                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //                       }
    //                     },
    //                     builder: (BuildContext context, postBlocState) {
    //                       return AnimatedGestureButton(
    //                         animate: postBlocState is PostApiProcessing,
    //                         child: GestureDetector(
    //                           child: !liked!
    //                               ? const Icon(
    //                                   Icons.favorite_outline,
    //                                   size: 25,
    //                                 )
    //                               : const Icon(
    //                                   Icons.favorite,
    //                                   color: Color(0xffFF0000),
    //                                   size: 25,
    //                                 ),
    //                           onTap: () {
    //                             Map<String, dynamic> parameters = {
    //                               "token": user?.token ?? "",
    //                               "pratique_id": widget.data.id,
    //                               "etat": liked,
    //                             };
    //                             likePratique(parameters: parameters);
    //                           },
    //                         ),
    //                       );
    //                     },
    //                   );
    //                 case AuthenticationStatus.unknown:
    //                 case AuthenticationStatus.unauthenticated:
    //                 case AuthenticationStatus.failure:
    //                   return const Center(child: SizedBox.shrink());
    //               }
    //             })
    //           ],
    //         ),
    //         const SizedBox(height: 10),
    //         GestureDetector(
    //           onTap: () {
    //             ShowBottomSheetPratique(context, widget.data);
    //           },
    //           child: Container(
    //             width: MediaQuery.of(context).size.width * 20,
    //             height: 100,
    //             clipBehavior: Clip.antiAlias,
    //             decoration:
    //                 BoxDecoration(borderRadius: BorderRadius.circular(8)),
    //             child: CustomCachedNetworkImage(
    //               imageUrl: widget.data.image ?? '',
    //               fallBackAsset: 'assets/images/pratique_fallback.png',
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         GestureDetector(
    //           onTap: () {
    //             print("${widget.data.id}");
    //             ShowBottomSheetPratique(context, widget.data);
    //           },
    //           child: Container(
    //             height: 30,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10),
    //               color: primaryColor,
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Flexible(
    //                     child: Text(
    //                       'Voir Plus',
    //                       overflow: TextOverflow.ellipsis,
    //                       style: GoogleFonts.arimo(
    //                         color: Colors.white,
    //                         fontSize: textConstant,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

Future<dynamic> ShowBottomSheetPratique(BuildContext context, Pratique pratique,
    {Function? customFunction}) {
  DataBloc<List<Pratique>> practiceBloc = DataBloc<List<Pratique>>(
      (response) => Pratique.fromJsonList(response),
      Pratique.getEndpoint(isPagination: false),
      isGraphQl: true,
      isPagination: false,
      attributeToGet: Pratique.shrinkedAttributs());

  return showModalBottomSheet(
      context: context,
      builder: (BuildContext currentContext) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            // height: 200,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(spacingConstant),
                    topRight: Radius.circular(spacingConstant))),
            child: Padding(
              padding: const EdgeInsets.all(spacingConstant),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 2,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(spacingConstant))),
                      ),
                    ),
                    const SizedBox(
                      height: spacingConstant,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 25,
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: CustomCachedNetworkImage(
                        imageUrl: pratique.image ?? '',
                        fallBackAsset: 'assets/images/pratique_fallback.png',
                      ),
                    ),
                    const SizedBox(
                      height: spacingConstant,
                    ),
                    Text(
                      pratique.designation.toString().toCapitalized,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: spacingConstant / 2),
                    Text(
                        pratique.description != null
                            ? pratique.description.toString()
                            : "",
                        style: GoogleFonts.arimo(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(
                      height: spacingConstant,
                    ),
                    GestureDetector(
                      onTap: () {
                        int id = pratique.id ?? 0;
                        // int id = 10;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Planning(id: id)));
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'Voir les cours',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.arimo(
                                    color: Colors.white,
                                    fontSize: textConstant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
