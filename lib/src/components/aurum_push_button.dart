import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/aurum_maybe_marquee.dart';
import '../utils/aurum_text.dart';
import '../utils/spacing_extension.dart';

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
    this.padding,
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
  final EdgeInsetsGeometry? padding;

  @override
  State<AurumPushButton> createState() => _AurumPushButtonState();
}

class _AurumPushButtonState extends State<AurumPushButton> {
  final RxBool _showShadow = true.obs;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final Color effectiveForegroundColor = widget.buttonTextColor ?? scheme.onPrimary;
    final Color effectiveBorderColor = widget.buttonBorderColor ?? scheme.primary;
    final Color effectiveBackgroundColor = widget.buttonBackgroundColor ?? scheme.primary;

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: kMinInteractiveDimension,
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
          child: Obx(() {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: kToolbarHeight,
              width: double.infinity,
              alignment: Alignment.center,
              transform: _showShadow.value
                  ? Matrix4.identity()
                  : Matrix4.translationValues(4, 4, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: effectiveBorderColor),
                color: effectiveBackgroundColor,
              ),
              child: widget.needIconButton
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          widget.iconButtonImage,
                          height: 24,
                          width: 24,
                          fit: BoxFit.contain,
                          color: widget.iconButtonColor ?? effectiveForegroundColor,
                        ),
                        8.w,
                        Flexible(
                          child: AurumText.f16w600(
                            widget.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            color: effectiveForegroundColor,
                          ),
                        ),
                      ],
                    )
                  : AurumText.f16w600(
                      widget.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: effectiveForegroundColor,
                    ),
            );
          }),
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
