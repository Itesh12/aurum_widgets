import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_cache_manager/flutter_cache_manager.dart";
import "package:shimmer/shimmer.dart";
import "../utils/aurum_assets.dart";

/// A widget that displays a cached network image with a shimmer placeholder.
class AurumCachedImage extends StatelessWidget {
  const AurumCachedImage({
    required this.imageUrl,
    required this.fit,
    this.height,
    this.width,
    this.placeholder,
    this.imageType = 0,
    this.personImage = 0,
    this.circleView = false,
    super.key,
  });

  /// The URL of the image to display.
  final String imageUrl;

  /// The height of the image.
  final double? height;

  /// The width of the image.
  final double? width;

  /// How to fit the image into the bounds.
  final BoxFit fit;

  /// Custom placeholder widget to show while loading.
  final Widget? placeholder;

  /// Type indicator for broken images (0: logo, 1: cover).
  final int imageType;

  /// Whether the image is a person profile (uses different placeholder).
  final int personImage;

  /// Whether to show the image in a circular view.
  final bool circleView;

  static final CacheManager _customCacheManager = CacheManager(
    Config(
      "aurumImageCache",
      fileService: HttpFileService(),
    ),
  );

  /// Clears a specific image from the cache.
  static Future<void> clearImageFromCache(String url) async {
    await _customCacheManager.removeFile(url);
  }

  static Widget _buildShimmer(double? height, double? width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final double resolvedHeight = height ?? double.infinity;
    final double resolvedWidth = width ?? double.infinity;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: _customCacheManager,
      height: resolvedHeight,
      width: resolvedWidth,
      fit: fit,
      placeholder: (_, __) => placeholder ?? _buildShimmer(height, width),
      errorWidget: (_, __, ___) => personImage == 1
          ? Image.asset(
              AurumAssetsImages().placeholderImage01,
              height: resolvedHeight,
              width: resolvedWidth,
              fit: BoxFit.contain,
              package: 'aurum_widgets',
            )
          : Image.asset(
              imageType == 1 ? AurumAssetsImages().coverBrokenImage : AurumAssetsImages().logoBrokenImage,
              height: resolvedHeight,
              width: resolvedWidth,
              fit: BoxFit.contain,
              package: 'aurum_widgets',
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget = _buildImage(context);

    if (circleView) {
      return ClipOval(
        child: SizedBox(
          height: height,
          width: width,
          child: imageWidget,
        ),
      );
    }

    return imageWidget;
  }
}
