import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointage_mobile/components/custom_cached_network_image.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/core/utils/Capitalized.dart';
import 'package:pointage_mobile/screens/Home/pratique_page.dart';
import 'package:pointage_mobile/services/api/models/type_pratique_model.dart';
import 'package:pointage_mobile/services/data_bloc/bloc/data_bloc.dart';

import '../services/post_api_bloc.dart';

class CardTypePratique extends StatefulWidget {
  final TypePratique data;
  final Function? handlePress;
  // final Map<String, dynamic>? filter;

  const CardTypePratique({
    super.key,
    // this.filter,
    required this.data,
    this.handlePress,
  });

  @override
  State<CardTypePratique> createState() => _CardTypePratiqueState();
}

class _CardTypePratiqueState extends State<CardTypePratique> {
  DataBloc? parentDataBloc;

  @override
  void initState() {
    super.initState();
  }

  initParentDataBloc() {
    parentDataBloc = BlocProvider.of<DataBloc<List<TypePratique>>>(context);
  }

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PratiquesPage(constantFilter: {'type_pratique_id': widget.data.id})));      
        },
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          width: MediaQuery.of(context).size.width * 0.45,
          height: 150,
          // height: 180,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: primaryColor.withOpacity(.2)),
          ),
          child: Stack(
            children: [
              // Positioned.fill(
              //   child: ColorFiltered(
              //     colorFilter: ColorFilter.mode(
              //       Colors.black.withOpacity(0.4), // brightness 0.6 environ
              //       BlendMode.darken,
              //     ),
              //     child: CustomCachedNetworkImage(
              //       imageUrl: widget.data.image ?? '',
              //       fallBackAsset: 'assets/images/pratique_fallback.png',
              //       // fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              // Positioned.fill(
              //   child: CustomCachedNetworkImage(
              //       imageUrl: widget.data.image ?? '',
              //       fallBackAsset: 'assets/images/pratique_fallback.png',
              //       // fit: BoxFit.cover,
              //   ),
              // ),

              Positioned.fill(
                child: Stack(
                  children: [
                    CustomCachedNetworkImage(
                      imageUrl: widget.data.image ?? '',
                      fallBackAsset: 'assets/images/pratique_fallback.png',
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.4), // Ajuste l’opacité
                    ),
                  ],
                ),
              ),

              // Titre en bas à gauche
              Positioned(
                left: 12,
                bottom: 12,
                right: 12,
                child: Text(
                  widget.data.designation.toString() ?? '',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.arimo(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        offset: const Offset(0, 1),
                        blurRadius: 3,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }
}
