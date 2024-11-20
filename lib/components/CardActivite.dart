import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';

class Cardactivite extends StatelessWidget {
  final String? color;
  final Programme data;
  final Function() handlePress;
  const Cardactivite(
      {super.key,
      required this.color,
      required this.data,
      required this.handlePress});

  @override
  Widget build(BuildContext context) {
    int displayColor = 0xffFF0000;
    if (color == "success") {
      displayColor = 0xff28A745;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(displayColor).withOpacity(.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding_constant),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.professeurPratique?.pratique?.designation ?? "",
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.arimo(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.040),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/heure.svg'),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.010),
                    Text(
                      data.heureDebut ?? "",
                      style: const TextStyle(
                          color: Color(0xff838282), fontSize: 11),
                    )
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.040),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/person.svg'),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.010),
                    Text(
                      data.professeurPratique?.professeur?.user?.name ?? "",
                      style: const TextStyle(
                          color: Color(0xff838282), fontSize: 11),
                    )
                  ],
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IntrinsicWidth(
                  child: GestureDetector(
                    onTap: handlePress,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color(displayColor),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: padding_constant, right: padding_constant),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Reservé',
                                style: GoogleFonts.arimo(
                                    fontSize: 11, fontWeight: FontWeight.bold)),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.020),
                            SvgPicture.asset('assets/icons/play.svg'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/icons/woman.png',
                  color: Color(displayColor),
                  height: 60,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Image.asset('assets/icons/woman.png', height: 50,)