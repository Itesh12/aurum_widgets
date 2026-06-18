import "package:flutter/material.dart";
import "package:get/get.dart";
import "../utils/aurum_text.dart";

import "../utils/spacing_extension.dart";

/// A custom outlined button with a modern look and consistent padding.
// class AurumOutlinedButton extends StatelessWidget {
//   const AurumOutlinedButton({
//     required this.text,
//     this.buttonIconColor,
//     required this.onPressed,
//     this.needIcon = false,
//     this.icon = const SizedBox(),
//     this.needIconbutton = false,
//     this.needSuffixIcon = false,
//     this.iconButtonImage = "",
//     this.buttonTextColor,
//     this.buttonBorderColor,
//     this.backgroundColor,
//     this.textStyle,
//     super.key,
//   });

//   /// Whether to show an icon.
//   final bool needIcon;

//   /// A custom widget to show as the icon.
//   final Widget icon;

//   /// The text to display on the button.
//   final String text;

//   /// Custom color for the icon.
//   final Color? buttonIconColor;

//   /// Called when the button is pressed.
//   final Function()? onPressed;

//   /// Whether to show an image-based icon.
//   final bool needIconbutton;

//   /// Whether the image-based icon should be at the end of the text.
//   final bool needSuffixIcon;

//   /// The image path for the button icon.
//   final String iconButtonImage;

//   /// Custom color for the button text.
//   final Color? buttonTextColor;

//   /// Custom color for the button border.
//   final Color? buttonBorderColor;

//   /// Custom color for the dynamic background.
//   final Color? backgroundColor;

//   /// Custom text style for the label.
//   final TextStyle? textStyle;

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;

//     // Fallbacks: derive from theme if not provided
// // typically main accent

//     return SizedBox(
//       height: kMinInteractiveDimension,
//       width: double.infinity,
//       child: OutlinedButton.icon(
//         style: OutlinedButton.styleFrom(
//           elevation: 4,
//           side: BorderSide(color: buttonBorderColor ?? colorScheme.primary),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         icon: needIcon ? icon : const SizedBox(),
//         label: needIconbutton
//             ? Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Visibility(
//                     visible: !needSuffixIcon,
//                     child: Image.asset(
//                       iconButtonImage,
//                       height: 24,
//                       width: 24,
//                       color: buttonIconColor,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   8.w,
//                   Flexible(
//                     child: AurumText.f16w500(
//                       text,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   8.w,
//                   Visibility(
//                     visible: needSuffixIcon,
//                     child: Image.asset(
//                       iconButtonImage,
//                       height: 16,
//                       width: 16,
//                       fit: BoxFit.contain,
//                       color: colorScheme.primary,
//                     ),
//                   ),
//                 ],
//               )
//             : FittedBox(
//                 fit: BoxFit.scaleDown,
//                 child: AurumText.f14w500(
//                   text,
//                   color: buttonTextColor,
//                 ),
//               ),
//         onPressed: () async {
//           HapticFeedback.lightImpact();
//           _unfocus();
//           await onPressed?.call();
//         },
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

class AurumOutlinedButton extends StatefulWidget {
  const AurumOutlinedButton({
    required this.text,
    required this.onPressed,
    this.buttonIconColor,
    this.needIcon = false,
    this.icon = const SizedBox(),
    this.needIconbutton = false,
    this.needSuffixIcon = false,
    this.iconButtonImage = "",
    this.buttonTextColor,
    this.buttonBorderColor,
    this.customHeight,
    this.customBorderHeight,
    this.customFontSize,
    this.customIconSize,
    this.backgroundColor,
    this.textStyle,
    this.width = double.infinity,
    this.fontWeight,
    super.key,
  });

  final bool needIcon;
  final Widget icon;
  final String text;
  final Color? buttonIconColor;
  final Function()? onPressed;
  final bool needIconbutton;
  final bool needSuffixIcon;
  final String iconButtonImage;
  final Color? buttonTextColor;
  final Color? buttonBorderColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? width;
  final double? customHeight;
  final double? customBorderHeight;
  final double? customFontSize;
  final double? customIconSize;
  final FontWeight? fontWeight;

  @override
  State<AurumOutlinedButton> createState() => _AurumOutlinedButtonState();
}

class _AurumOutlinedButtonState extends State<AurumOutlinedButton> {
  final RxBool _showShadow = true.obs;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Resolve dynamic colors from the host application's theme
    final Color effectiveBorderColor = widget.buttonBorderColor ?? colorScheme.primary;
    final Color effectiveTextColor = widget.buttonTextColor ?? effectiveBorderColor;
    final Color effectiveIconColor = widget.buttonIconColor ?? effectiveTextColor;
    final Color topBgColor = widget.backgroundColor ?? Colors.transparent;
    final Color bottomBgColor = widget.backgroundColor ?? Colors.transparent;

    return SizedBox(
      height: widget.customHeight ?? 44 + 4,
      width: widget.width,
      child: GestureDetector(
        onTap: () async {
          _unfocus();
          _showShadow(true);
          await widget.onPressed?.call();
        },
        onTapDown: (_) => _showShadow(false),
        onTapUp: (_) => _showShadow(true),
        onTapCancel: () => _showShadow(true),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: 48,
                width: widget.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                transform: _showShadow.value ? Matrix4.identity() : Matrix4.translationValues(0, 2, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _showShadow.value
                      ? [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 4),
                            blurRadius: 6,
                          ),
                        ]
                      : [],
                  border: Border.all(
                    color: effectiveBorderColor,
                    width: widget.customBorderHeight ?? 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      topBgColor,
                      bottomBgColor,
                    ],
                    stops: const <double>[0.0, 1.0],
                  ),
                ),
                child: widget.needIconbutton
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Visibility(
                            visible: !widget.needSuffixIcon,
                            child: Image.asset(
                              widget.iconButtonImage,
                              height: widget.customIconSize ?? 24,
                              width: widget.customIconSize ?? 24,
                              color: effectiveIconColor,
                              fit: BoxFit.contain,
                            ),
                          ),
                          8.w,
                          Flexible(
                            child: AurumText(
                              text: widget.text,
                              fontSize: widget.customFontSize ?? 16,
                              fontWeight: widget.fontWeight ?? FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              color: effectiveTextColor,
                            ),
                          ),
                          8.w,
                          Visibility(
                            visible: widget.needSuffixIcon,
                            child: Image.asset(
                              widget.iconButtonImage,
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (widget.needIcon) ...<Widget>[
                            widget.icon,
                            8.w,
                          ],
                          Flexible(
                            child: AurumText(
                              text: widget.text,
                              fontSize: widget.customFontSize ?? 16,
                              fontWeight: widget.fontWeight ?? FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              color: effectiveTextColor,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
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
