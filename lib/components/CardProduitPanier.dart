import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';

import 'package:yogivida_mobile/services/api/models/pratique_model.dart';

class CardProduitPanier extends StatefulWidget {
  final Pratique data;
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
  @override
  void initState() {
    super.initState();
    // liked = widget.data.liked;
    liked = false;
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
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Image.asset(
                  widget.data.image??"",
                  fit: BoxFit.cover,
                  height: 105,
                  width: 70,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            (widget.data.designation??"").toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.arimo(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.040,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          ("80.000" ' xof').toUpperCase(),
                          style: GoogleFonts.arimo(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.040,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
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
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: primaryColor, width: 1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    'UM',
                                    style: TextStyle(fontSize: 8),
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
