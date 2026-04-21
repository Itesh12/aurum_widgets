import "package:flutter/material.dart";
import "../utils/aurum_text.dart";

import "../utils/spacing_extension.dart";

/// A custom outlined button with a modern look and consistent padding.
class AurumOutlinedButton extends StatelessWidget {
  const AurumOutlinedButton({
    required this.text,
    this.buttonIconColor,
    required this.onPressed,
    this.needIcon = false,
    this.icon = const SizedBox(),
    this.needIconbutton = false,
    this.needSuffixIcon = false,
    this.iconButtonImage = "",
    this.buttonTextColor,
    this.buttonBorderColor,
    this.backgroundColor,
    this.textStyle,
    super.key,
  });

  /// Whether to show an icon.
  final bool needIcon;

  /// A custom widget to show as the icon.
  final Widget icon;

  /// The text to display on the button.
  final String text;

  /// Custom color for the icon.
  final Color? buttonIconColor;

  /// Called when the button is pressed.
  final Function()? onPressed;

  /// Whether to show an image-based icon.
  final bool needIconbutton;

  /// Whether the image-based icon should be at the end of the text.
  final bool needSuffixIcon;

  /// The image path for the button icon.
  final String iconButtonImage;

  /// Custom color for the button text.
  final Color? buttonTextColor;

  /// Custom color for the button border.
  final Color? buttonBorderColor;

  /// Custom color for the dynamic background.
  final Color? backgroundColor;

  /// Custom text style for the label.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Fallbacks: derive from theme if not provided
// typically main accent

    return SizedBox(
      height: kMinInteractiveDimension,
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          elevation: 4,
          side: BorderSide(color: buttonBorderColor ?? colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: needIcon ? icon : const SizedBox(),
        label: needIconbutton
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Visibility(
                    visible: !needSuffixIcon,
                    child: Image.asset(
                      iconButtonImage,
                      height: 24,
                      width: 24,
                      color: buttonIconColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                  8.w,
                  Flexible(
                    child: AurumText.f16w500(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  8.w,
                  Visibility(
                    visible: needSuffixIcon,
                    child: Image.asset(
                      iconButtonImage,
                      height: 16,
                      width: 16,
                      fit: BoxFit.contain,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: AurumText.f14w500(
                  text,
                  color: buttonTextColor,
                ),
              ),
        onPressed: () async {
          _unfocus();
          await onPressed?.call();
        },
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
