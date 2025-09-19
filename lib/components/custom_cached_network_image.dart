import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yogivida_mobile/constant.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String? fallBackAsset;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fallBackAsset,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, progress) => const Center(
        child: Loader1(size: 8),
      ),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        if (fallBackAsset != null && fallBackAsset!.isNotEmpty) {
          return Image.asset(fallBackAsset!, fit: BoxFit.cover);
        }
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }
}
