import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/aurum_text.dart';
import '../utils/spacing_extension.dart';
import '../utils/aurum_maybe_marquee.dart';

/// A custom push button with a shadow effect and optional icon support.
///
/// Uses [GetX] for animation state management.
// class AurumPushButton extends StatefulWidget {
//   const AurumPushButton({
//     required this.text,
//     required this.onPressed,
//     this.needIconButton = false,
//     this.iconButtonImage = "",
//     this.buttonTextColor,
//     this.buttonBackgroundColor,
//     this.buttonBorderColor,
//     this.iconButtonColor,
//     this.padding,
//     super.key,
//   });

//   /// The text to display on the button.
//   final String text;

//   /// Called when the button is tapped.
//   final Function() onPressed;

//   /// Whether to show an icon inside the button.
//   final bool needIconButton;

//   /// The image path for the button icon.
//   final String iconButtonImage;

//   /// Custom color for the button text.
//   final Color? buttonTextColor;

//   /// Custom color for the button background.
//   final Color? buttonBackgroundColor;

//   /// Custom color for the button border.
//   final Color? buttonBorderColor;

//   /// Custom color for the icon.
//   final Color? iconButtonColor;

//   /// Optional padding around the button.
//   final EdgeInsetsGeometry? padding;

//   @override
//   State<AurumPushButton> createState() => _AurumPushButtonState();
// }

// class _AurumPushButtonState extends State<AurumPushButton> {
//   final RxBool _showShadow = true.obs;

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme scheme = Theme.of(context).colorScheme;

//     final Color effectiveForegroundColor = widget.buttonTextColor ?? scheme.onPrimary;
//     final Color effectiveBorderColor = widget.buttonBorderColor ?? scheme.primary;
//     final Color effectiveBackgroundColor = widget.buttonBackgroundColor ?? scheme.primary;

//     return Padding(
//       padding: widget.padding ?? EdgeInsets.zero,
//       child: SizedBox(
//         height: kMinInteractiveDimension,
//         width: double.infinity,
//         child: GestureDetector(
//           onTap: () async {
//             HapticFeedback.lightImpact();
//             _unfocus();
//             _showShadow(true);
//             await widget.onPressed();
//           },
//           onTapDown: (_) => _showShadow(false),
//           onTapUp: (_) => _showShadow(true),
//           onTapCancel: () => _showShadow(true),
//           child: Obx(() {
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 100),
//               height: kToolbarHeight,
//               width: double.infinity,
//               alignment: Alignment.center,
//               transform: _showShadow.value
//                   ? Matrix4.identity()
//                   : Matrix4.translationValues(4, 4, 0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: effectiveBorderColor),
//                 color: effectiveBackgroundColor,
//               ),
//               child: widget.needIconButton
//                   ? Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Image.asset(
//                           widget.iconButtonImage,
//                           height: 24,
//                           width: 24,
//                           fit: BoxFit.contain,
//                           color: widget.iconButtonColor ?? effectiveForegroundColor,
//                         ),
//                         8.w,
//                         Flexible(
//                           child: AurumText.f16w600(
//                             widget.text,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             color: effectiveForegroundColor,
//                           ),
//                         ),
//                       ],
//                     )
//                   : AurumText.f16w600(
//                       widget.text,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       color: effectiveForegroundColor,
//                     ),
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   void _unfocus() {
//     final FocusNode? focus = FocusManager.instance.primaryFocus;
//     if (focus?.hasFocus ?? false) {
//       focus?.unfocus();
//     }
//   }
// }

class AurumPushButton extends StatefulWidget {
  const AurumPushButton({
    required this.text,
    required this.onPressed,
    this.needIconButton = false,
    this.iconButtonImage = "",
    this.buttonTextColor,
    this.buttonBackgroundColor,
    this.buttonBorderColor,
    this.iconButtonColor,
    this.marquee = false,
    this.isLoading = false,
    this.isDeleteColor = false,
    super.key,
  });

  final String text;
  final Function() onPressed;
  final bool needIconButton;
  final String iconButtonImage;
  final Color? buttonTextColor;
  final Color? buttonBackgroundColor;
  final Color? buttonBorderColor;
  final Color? iconButtonColor;
  final bool marquee;
  final bool isLoading;
  final bool isDeleteColor;

  @override
  State<AurumPushButton> createState() => _AurumPushButtonState();
}

class _AurumPushButtonState extends State<AurumPushButton> {
  final RxBool _showShadow = true.obs;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Resolve gradient top and bottom colors dynamically based on the host app's active theme
    final Color defaultTopColor = widget.isDeleteColor 
        ? scheme.error 
        : (Color.lerp(scheme.primary, Colors.white, 0.1) ?? scheme.primary);
        
    final Color defaultBottomColor = widget.isDeleteColor 
        ? (Color.lerp(scheme.error, Colors.black, 0.15) ?? scheme.error)
        : (Color.lerp(scheme.primary, Colors.black, 0.15) ?? scheme.primary);

    final Color effectiveBorderColor = widget.buttonBorderColor ?? 
        (widget.isDeleteColor ? scheme.error : scheme.primary);

    final Color effectiveShadowColor = widget.buttonBackgroundColor ?? defaultTopColor;

    return SizedBox(
      height: 44 + 4,
      width: double.infinity,
      child: GestureDetector(
        onTap: () async {
          _unfocus();
          _showShadow(true);
          await widget.onPressed();
        },
        onTapDown: (_) => _showShadow(false),
        onTapUp: (_) => _showShadow(true),
        onTapCancel: () => _showShadow(true),
        child:  Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: 48,
                width: double.infinity,
                alignment: Alignment.center,
                transform: _showShadow.value ? Matrix4.identity() : Matrix4.translationValues(0, 2, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _showShadow.value
                      ? [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: effectiveShadowColor.withOpacity(0.3),
                            offset: const Offset(0, 4),
                            blurRadius: 6,
                          ),
                        ]
                      : [],
                  border: Border.all(color: effectiveBorderColor),
                  gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            widget.buttonBackgroundColor ?? defaultTopColor,
                            widget.buttonBackgroundColor ?? defaultBottomColor,
                          ],
                          stops: const <double>[0.0, 1.0],
                        ),
                ),
                child: Center(
                      child: widget.needIconButton
                          ? widget.marquee
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    8.w,
                                    Image.asset(
                                      widget.iconButtonImage,
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.contain,
                                      color: widget.iconButtonColor ?? Colors.white,
                                    ),
                                    8.w,
                                    Flexible(
                                      child: AurumMaybeMarqueeText(
                                        text: widget.text,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 4)
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      widget.iconButtonImage,
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.contain,
                                      color: widget.iconButtonColor ?? Colors.white,
                                    ),
                                    8.w,
                                    Flexible(
                                      child: AurumText(
                                        text: widget.text,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: widget.buttonTextColor ?? Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                          : AurumText(
                              text: widget.text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: widget.buttonTextColor ?? Colors.white,
                            ),
            ),
          ),
        ),
      ),
    );
  }

  void _unfocus() {
    final FocusNode? focus = FocusManager.instance.primaryFocus;
    if (focus?.hasFocus ?? false) {
      focus?.unfocus();
    }
  }
}