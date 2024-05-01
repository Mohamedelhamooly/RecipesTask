import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      this.data,
         this.height = double.infinity,
        this.width = double.infinity,
        this.fit = BoxFit.scaleDown,
        this.alignment = Alignment.center,
        this.isImageProvider = false,
        this.isSplashVideo = false,
        this.loadingSize = 35,});

  final String? data;
  final BoxFit fit;
  final double height;
  final double width;
  final double loadingSize;
  final Alignment alignment;
  final bool isImageProvider;
  final bool isSplashVideo;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      data!,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment,
      loadStateChanged: (ExtendedImageState value) {
        if (value.extendedImageLoadState == LoadState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.extendedImageLoadState == LoadState.failed) {
          return const Center(
            child: FlutterLogo(),
          );
        }
        return null;
      },
      cacheMaxAge: const Duration(days: 2),
      compressionRatio: 0.35,
      timeRetry: const Duration(milliseconds: 1500),
      cacheHeight: 45,
      cacheWidth: 45,
      enableMemoryCache: false,
      enableLoadState: false,
      clearMemoryCacheWhenDispose: true,
    );
  }
}
