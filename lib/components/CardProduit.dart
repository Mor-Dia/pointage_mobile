import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';

class CardProduit extends StatefulWidget {
  final Pratique data;
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
  void initState() {
    super.initState();
    liked = widget.data.liked;
  }

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
            child: Image.asset(
              widget.data.image,
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.data.nomPratique.toUpperCase() +
                      'dcisldjc,zpodckzeopc',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.arimo(
                    fontSize: MediaQuery.of(context).size.width * 0.040,
                  ),
                ),
              ),
              GestureDetector(
                child: liked == false
                    ? Icon(
                        Icons.favorite_outline,
                        size: 25,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Color(0xffFF0000),
                        size: 25,
                      ),
                onTap: () {
                  setState(() {
                    print(liked);
                    liked = !liked!;
                  });
                },
              )
            ],
          ),
          SizedBox(height: 5),
          Text(
            textAlign: TextAlign.start,
            ("80.000" + ' xof').toUpperCase(),
            style: GoogleFonts.arimo(
                fontSize: MediaQuery.of(context).size.width * 0.040,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
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
                  child: Center(
                    child: Text(
                      '-',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  qte.toString(),
                  textAlign: TextAlign.center,
                ),
                width: 40,
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
                  child: Center(
                    child: Text(
                      '+',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
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
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
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
          SizedBox(height: 10),
          Container(
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
                  SizedBox(
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
        ]),
      ),
    );
  }
}
