import 'package:authentication_repository/authentication_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/custom_cached_network_image.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
import 'package:yogivida_mobile/services/api/models/pratique_model.dart';

import '../core/models/user_model.dart';
import '../services/authentication_bloc/authentication_bloc.dart';
import '../services/post_api_bloc.dart';
import 'animated_gesture_detector.dart';

class CardPratique extends StatefulWidget {
  final Pratique data;
  final Function? handlePress;
  final Function? updateFunction;

  const CardPratique(
      {super.key, required this.data, this.handlePress, this.updateFunction});

  @override
  State<CardPratique> createState() => _CardPratiqueState();
}

class _CardPratiqueState extends State<CardPratique> {
  late PostApiBloc favorisPostBloc;

  bool? liked;

  @override
  void initState() {
    super.initState();
    favorisPostBloc = PostApiBloc();
    liked = widget.data.favoris;
  }

  likePratique({required Map<String, dynamic> parameters}) {
    favorisPostBloc.add(
        PostApiMakeCall(endpoint: 'pratique_favoris', parameters: parameters));
  }

  changeStateFavoris() {
    setState(() {
      liked = !liked!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: primaryColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(spacingConstant),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.data.designation.toString().toCapitalized ?? '',
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.arimo(
                        fontSize: textConstant, fontWeight: FontWeight.bold),
                  ),
                ),
                BlocBuilder<AuthenticationBloc<Utilisateur>,
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  liked!
                                      ? 'Ajouter au favoris'
                                      : 'Retirer des favoris',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green[400],
                              ),
                            );
                            print(
                                " UPDATE PRATIQUE SHOULD UPDATE SOON ${widget.updateFunction}");
                            if (widget.updateFunction != null) {
                              print(" UPDATE PRATIQUE SHOULD UPDATE");
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
                            child: GestureDetector(
                              child: !liked!
                                  ? const Icon(
                                      Icons.favorite_outline,
                                      size: 25,
                                    )
                                  : const Icon(
                                      Icons.favorite,
                                      color: Color(0xffFF0000),
                                      size: 25,
                                    ),
                              onTap: () {
                                Map<String, dynamic> parameters = {
                                  "token": user?.token ?? "",
                                  "pratique_id": widget.data.id,
                                  "etat": liked,
                                };
                                likePratique(parameters: parameters);
                              },
                            ),
                          );
                        },
                      );
                    case AuthenticationStatus.unknown:
                    case AuthenticationStatus.unauthenticated:
                    case AuthenticationStatus.failure:
                      return const Center(child: SizedBox.shrink());
                  }
                })
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: CustomCachedNetworkImage(
                      imageUrl: widget.data.image ?? '',
                      fallBackAsset: 'assets/images/pratique_fallback.png')),
            ),
          ],
        ),
      ),
    );
  }
}
