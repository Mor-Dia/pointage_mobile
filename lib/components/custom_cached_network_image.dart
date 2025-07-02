import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yogivida_mobile/constant.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String? fallBackAsset;
  const CustomCachedNetworkImage(
      {super.key, required this.imageUrl, this.fallBackAsset});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      progressIndicatorBuilder: (context, url, progress) => Center(
          // child: CircularProgressIndicator(
          //   value: progress.progress,
          // ),
          child: Loader1(size: 8)),
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            // colorFilter: const ColorFilter.mode(
            //   Colors.red,
            //   BlendMode.colorBurn,
            // ),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        if (fallBackAsset != null) {
          return Image.asset(fallBackAsset ?? "");
        }
        return const Icon(Icons.error);
      },
    );
  }
}
