import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/produit_model.dart';

class CardProduit extends StatefulWidget {
  final Produit data;
  final Function()? handlePress;
  const CardProduit({
    super.key,
    required this.data,
    this.handlePress,
  });

  @override
  State<CardProduit> createState() => _CardProduitState();
}

class _CardProduitState extends State<CardProduit> {
  @override
  bool? liked;
  int qte = 0;
  int selectedTaille = 0;
  @override
  void initState() {
    super.initState();
    liked = false;
    // liked = widget.data.liked;
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
            child: Container(
              height: 100,
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                imageUrl: widget.data.image ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                // placeholder: (context, url) => const CircleAvatar(
                //   backgroundColor: Colors.amber,
                //   radius: 150,
                // )
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
                    fontSize: MediaQuery.of(context).size.width * 0.040,
                  ),
                ),
              ),
              GestureDetector(
                child: liked == false
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
                  setState(() {
                    liked = !liked!;
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            textAlign: TextAlign.start,
            ("80.000" ' xof').toUpperCase(),
            style: GoogleFonts.arimo(
                fontSize: MediaQuery.of(context).size.width * 0.040,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => {
                  setState(() {
                    if (qte > 0) {
                      qte -= 1;
                    }
                  })
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(20)),
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
                      borderRadius: BorderRadius.circular(20)),
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
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.data.produitTailles?.map((toElement) {
                    int index = widget.data.produitTailles!.indexOf(toElement);
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTaille = index;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: index == selectedTaille
                                    ? Border.all(color: primaryColor, width: 1)
                                    : Border.all(
                                        color: Colors.transparent, width: 1),
                                borderRadius: BorderRadius.circular(20)),
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
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => widget.handlePress,
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
                    SvgPicture.asset('assets/icons/cadit.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        'Ajouter au panier',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.arimo(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.030,
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
