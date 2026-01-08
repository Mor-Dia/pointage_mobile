import 'package:authentication_repository/authentication_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointage_mobile/components/ButtonField.dart';
import 'package:pointage_mobile/components/TopDialogNotification.dart';
import 'package:pointage_mobile/components/custom_cached_network_image.dart';
import 'package:pointage_mobile/components/please_login_widget.dart';
import 'package:pointage_mobile/constant.dart';

import 'package:pointage_mobile/services/api/models/pratique_model.dart';
import 'package:pointage_mobile/services/api/models/produit_model.dart';
import 'package:pointage_mobile/services/api/models/taille_model.dart';
import 'package:pointage_mobile/services/post_api_bloc.dart';

import '../core/models/user_model.dart';
import '../services/authentication_bloc/authentication_bloc.dart';
import 'animated_gesture_detector.dart';

class CardProduitFavoris extends StatefulWidget {
  final Produit data;
  final Function(Map<String, dynamic>)? handlePress;
  final Function? updateFunction;
  const CardProduitFavoris(
      {super.key, required this.data, this.handlePress, this.updateFunction});

  @override
  State<CardProduitFavoris> createState() => _CardProduitFavorisState();
}

class _CardProduitFavorisState extends State<CardProduitFavoris> {
  late PostApiBloc favorisPostBloc;
  bool? liked;
  int qte = 1;

  Taille? selectedTaille;
  int indexOfSelectedTaille = 0;

  @override
  void initState() {
    super.initState();
    favorisPostBloc = PostApiBloc();
    liked = widget.data.favoris;
  }

  likeProduct({required Map<String, dynamic> parameters}) {
    favorisPostBloc
        .add(PostApiMakeCall(endpoint: 'favoris', parameters: parameters));
  }

  changeStateFavoris() {
    setState(() {
      liked = !liked!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: primaryColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {
                print('Image cliquée' + widget.data.image.toString());
                ShowBottomSheetBoutique(
                    context, widget.data, widget.handlePress as Function);
              },
              child: Container(
                height: 100,
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      Center(child: Loader1(size: 8)),
                  imageUrl: widget.data.image ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: const Icon(
                      Icons.image,
                      size: 50,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${(widget.data.designation ?? "").toUpperCase()}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.arimo(
                    fontSize: textConstant,
                  ),
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
                          TopDialogNotification.show(context,
                              message: liked!
                                  ? 'Ajouter au favoris'
                                  : 'Retirer des favoris',
                              isError: false);
                          if (widget.updateFunction != null) {
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
                                "produit_id": widget.data.id,
                                "etat": liked,
                              };
                              likeProduct(parameters: parameters);
                            },
                          ),
                        );
                      },
                    );
                  case AuthenticationStatus.unknown:
                  case AuthenticationStatus.unauthenticated:
                  case AuthenticationStatus.failure:
                    return const Center(child: PleaseLoginWidget());
                }
              })
            ],
          ),
          const SizedBox(height: 5),
          Text(
            textAlign: TextAlign.start,
            widget.data.prixSiteWebFr.toString(),
            style: GoogleFonts.arimo(
                fontSize: textConstant, fontWeight: FontWeight.bold),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Visibility(
            visible: false,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => {
                    setState(() {
                      if (qte > 1) {
                        qte -= 1;
                      }
                    })
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(spacingConstant)),
                    child: const Center(
                      child: Text(
                        '-',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    qte.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    setState(() {
                      qte += 1;
                    })
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(spacingConstant)),
                    child: const Center(
                      child: Text(
                        '+',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          Visibility(
            visible: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.data.produitTailles?.map((Taille toElement) {
                      int index = widget.data.produitTailles!.indexOf(toElement);
                      // selectedTaille = toElement;
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                print(toElement);
                                indexOfSelectedTaille = index;
                                selectedTaille = toElement;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: index == indexOfSelectedTaille
                                      ? Border.all(color: primaryColor, width: 1)
                                      : Border.all(
                                          color: Colors.transparent, width: 1),
                                  borderRadius:
                                      BorderRadius.circular(spacingConstant)),
                              child: Center(
                                child: Text(
                                  toElement.taille.abreviation.toUpperCase(),
                                  style: const TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              print("taille selectedTaille: $selectedTaille");

              var authBloc = context.read<AuthenticationBloc<Utilisateur>>();
              Utilisateur? user = authBloc.state.user;

              // Vérifie si l'utilisateur est connecté
              if (user != null) {
                print(widget.data);
                String? token = user.token;
                int? client_id = user.id;
                int tailleId = widget.data.produitTailles?.first.taille_id ?? 0;
                print("Utilisateur papa $tailleId $token");
                if (widget.handlePress != null) {
                  widget.handlePress!({
                    'client_id': client_id,
                    'produit_id': widget.data.id,
                    'quantite': qte,
                    'taille_id': selectedTaille != null
                        ? selectedTaille?.taille_id
                        : widget.data.produitTailles?.first.taille_id ?? 0,
                    'token': token, // Passer le token de l'utilisateur
                  });
                }
              } else {
                print("Utilisateur non connecté 22");
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                TopDialogNotification.show(context,
                    message: "Veuillez vous connectez !", isError: true);
              }
            },
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.data.currentQuantity! >= 1
                    ? primaryColor
                    : Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/cadit.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        widget.data.currentQuantity! >= 1
                            ? 'Ajouter au panier'
                            : "Rupture de stock",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.arimo(
                          color: Colors.white,
                          fontSize: textminConstant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


Future<dynamic> ShowBottomSheetBoutique(
  BuildContext context,
  Produit produit,
  Function handlePress, {
  Function? customFunction,
}) {
  int qte = 1;
  Taille? selectedTaille;
  int indexOfSelectedTaille = -1;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext currentContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(spacingConstant),
                topRight: Radius.circular(spacingConstant),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(spacingConstant/2),
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
                            Radius.circular(spacingConstant),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: spacingConstant),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 150,
                      height: 220,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomCachedNetworkImage(
                        imageUrl: produit.image ?? '',
                        fallBackAsset: 'assets/images/pratique_fallback.png',
                      ),
                    ),
                    const SizedBox(height: spacingConstant),
                    Center(
                      child: Text(
                        produit.designation ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: spacingConstant / 2),
                    Center(
                      child: Text(
                        produit.description ?? '',
                        style: GoogleFonts.arimo(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: spacingConstant),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (qte > 1) setState(() => qte--);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(spacingConstant),
                            ),
                            child: const Center(child: Text('-', textAlign: TextAlign.center)),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Text(qte.toString(), textAlign: TextAlign.center),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => qte++),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(spacingConstant),
                            ),
                            child: const Center(child: Text('+', textAlign: TextAlign.center)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (produit.produitTailles != null && produit.produitTailles!.isNotEmpty)
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: produit.produitTailles!.map((tailleItem) {
                              int index = produit.produitTailles!.indexOf(tailleItem);
                              bool isSelected = index == indexOfSelectedTaille;
                        
                              return Padding(
                                padding: const EdgeInsets.only(right: 2, left:5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      indexOfSelectedTaille = index;
                                      selectedTaille = tailleItem;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: isSelected ? primaryColor : Colors.grey.shade300,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(spacingConstant),
                                    ),
                                    child: Center(
                                      child: Text(
                                        tailleItem.taille.abreviation.toUpperCase(),
                                        style: const TextStyle(fontSize: 10),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    const SizedBox(height: spacingConstant),
                    GestureDetector(
                      onTap: () {
                        var authBloc = context.read<AuthenticationBloc<Utilisateur>>();
                        Utilisateur? user = authBloc.state.user;

                        if (user != null) {
                          handlePress({
                            'client_id': user.id,
                            'produit_id': produit.id,
                            'quantite': qte,
                            'taille_id': selectedTaille?.taille_id ?? produit.produitTailles?.first.taille_id,
                            'token': user.token,
                          });
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          TopDialogNotification.show(
                            context,
                            message: "Veuillez vous connecter !",
                            isError: true,
                          );
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Ajouter au panier',
                            style: GoogleFonts.arimo(
                              color: Colors.white,
                              fontSize: textminConstant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
