import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/custom_cached_network_image.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/utils/Capitalized.dart';
import 'package:yogivida_mobile/services/api/models/pratique_model.dart';

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
    liked = false;
    // liked = widget.data.liked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
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
                Expanded(
                  child: Text(
                    widget.data.designation.toString().toCapitalized ?? '',
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.arimo(
                        fontSize:textConstant,
                        fontWeight: FontWeight.bold),
                  ),
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
            SizedBox(
              height: 100,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: CustomCachedNetworkImage(imageUrl: widget.data.image ?? '', fallBackAsset: 'assets/images/pratique_fallback.png')
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
                    fontSize: textminConstant),
              ),
            )
          ],
        ),
      ),
    );
  }
}
