import "dart:developer";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

/// A standardized wrapper for playing Lottie animations from assets.
class AurumLottieWidget extends StatelessWidget {
  const AurumLottieWidget({
    required this.path,
    required this.fit,
    required this.height,
    required this.width,
    this.repeat = true,
    this.onLoaded,
    super.key,
  });

  /// The asset path of the Lottie file.
  final String path;

  /// How to fit the animation into the bounds.
  final BoxFit fit;

  /// The height of the animation.
  final double height;

  /// The width of the animation.
  final double width;

  /// Whether the animation should repeat.
  final bool repeat;

  /// Callback when the animation has loaded.
  final void Function(LottieComposition)? onLoaded;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      path,
      fit: fit,
      height: height,
      width: width,
      repeat: repeat,
      frameRate: FrameRate.max,
      options: LottieOptions(),
      delegates: const LottieDelegates(),
      onWarning: log,
      alignment: Alignment.center,
      onLoaded: onLoaded,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.error_outline, color: Colors.red),
        );
      },
    );
  }
}
