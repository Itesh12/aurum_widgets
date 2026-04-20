import "package:flutter/material.dart";
import "../utils/app_text.dart";

import "../utils/spacing_extension.dart";

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
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
                    child: AppText.f16w500(
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
                child: AppText.f14w500(
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
