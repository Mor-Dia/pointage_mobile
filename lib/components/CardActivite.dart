import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
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
    // print("ici color" + this.color.toString());
    if (color == "success") {
      displayColor = 0xff28A745;
    } else {
      displayColor = 0xffDC3545;
    }

    print("ici color => " +
        this.color.toString() +
        "alors => " +
        displayColor.toString());

    return Container(
      constraints: BoxConstraints(maxWidth: 300),
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
              data.professeurPratique?.pratique?.designation
                      .toString()
                      .toCapitalized ??
                  "",
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.arimo(
                  fontWeight: FontWeight.bold, fontSize: textConstant),
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
                                    fontSize: 12, fontWeight: FontWeight.bold)),
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
