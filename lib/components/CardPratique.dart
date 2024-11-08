import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/constant.dart';

class CardPratique extends StatefulWidget {
  final Pratique data;
  final Function()? handlePress;
  const CardPratique({
    super.key,
    required this.data,
    this.handlePress,
  });

  @override
  State<CardPratique> createState() => _CardPratiqueState();
}

class _CardPratiqueState extends State<CardPratique> {
  @override
  bool? liked;
  @override
  void initState() {
    super.initState();
    liked = widget.data.liked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: primaryColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data.nomPratique,
                  style: GoogleFonts.arimo(
                      fontSize: MediaQuery.of(context).size.width * 0.040,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: liked == false
                      ? const Icon(Icons.favorite_outline)
                      : const Icon(Icons.favorite, color: Color(0xffFF0000)),
                  onTap: () {
                    setState(() {
                      liked = !liked!;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                widget.data.image,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: widget.handlePress,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: const Color(0xff15274d),
              ),
              child: Text(
                'Reserver',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.030),
              ),
            )
          ],
        ),
      ),
    );
  }
}
