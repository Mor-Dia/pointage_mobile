import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/panierBloc/panier_bloc_bloc.dart';

class CardProduitPanier extends StatefulWidget {
  final PanierPProduit data;
  final Function()? handlePress;
  const CardProduitPanier({
    super.key,
    required this.data,
    this.handlePress,
  });

  @override
  State<CardProduitPanier> createState() => _CardProduitPanierState();
}

class _CardProduitPanierState extends State<CardProduitPanier> {
  @override
  bool? liked;
  int qte = 0;
  String? token;
  String? userId;

  Future getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      userId = prefs.getString('user_id');
    });
    // context.read<PanierBlocBloc>().add(PanierBlocEvent.refresh(token: token!));
  }

  @override
  void initState() {
    super.initState();
    // liked = widget.data.liked;
    liked = false;
    qte = widget.data.qte!;
    getCredentials();
  }

  void addToPanier(PanierPProduit arg, int sentqte) async {
    int newQte = qte + sentqte;

    if (sentqte == 0) {
      newQte = 0;
    }

    Map<String, dynamic> newArg = {
      'client_id': userId,
      'produit_id': newQte == 0 ? widget.data.id : widget.data.produit?.id,
      'quantite': newQte,
      'taille_id': 1,
      'token': token
    };

    print(newArg);

    context
        .read<PanierBlocBloc>()
        .add(PanierBlocEvent.postPanier(body: newArg, token: token ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 1, color: primaryColor.withOpacity(.2))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            IntrinsicWidth(
              child: Container(
                  width: 50,
                  height: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: widget.data.produit!.image ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    // placeholder: (context, url) => const CircleAvatar(
                    //   backgroundColor: Colors.amber,
                    //   radius: 150,
                    // )
                  )),
            ),
            const SizedBox(width: spacingConstant),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            (widget.data.produit!.designation ?? "")
                                .toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.arimo(
                              fontSize:
                                  textConstant,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          (widget.data.produit!.prix.toString() + 'xof')
                              .toUpperCase(),
                          style: GoogleFonts.arimo(
                              fontSize:
                                  textConstant,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => {
                                addToPanier(widget.data, -1),
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
                                widget.data.qte.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {addToPanier(widget.data, 1)},
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
                        const SizedBox(
                          width: 10,
                        ),
                        IntrinsicWidth(
                          child: GestureDetector(
                            onTap: () {
                              addToPanier(widget.data, 0);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/trash.svg',
                                    width: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
