import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/aurum_text.dart';
import '../utils/spacing_extension.dart';

/// A premium elevated button with shadow animations and haptic feedback.
class AurumElevatedButton extends StatefulWidget {
  const AurumElevatedButton({
    required this.text,
    required this.onPressed,
    this.needIconButton = false,
    this.iconButtonImage = "",
    this.buttonTextColor,
    this.buttonBackgroundColor,
    this.buttonBorderColor,
    this.iconButtonColor,
    this.showLoader = false, // Added logic for loader if needed later
    super.key,
  });

  /// The text to display on the button.
  final String text;

  /// Called when the button is tapped.
  final Function()? onPressed;

  /// Whether to show an icon from an asset.
  final bool needIconButton;

  /// The asset path for the button icon.
  final String iconButtonImage;

  /// Custom color for the button text.
  final Color? buttonTextColor;

  /// Custom color for the background.
  final Color? buttonBackgroundColor;

  /// Custom color for the border.
  final Color? buttonBorderColor;

  /// Custom color for the icon.
  final Color? iconButtonColor;

  /// Whether to show a loading indicator.
  final bool showLoader;

  @override
  State<AurumElevatedButton> createState() => _AurumElevatedButtonState();
}

class _AurumElevatedButtonState extends State<AurumElevatedButton> {
  final RxBool _showShadow = true.obs;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final Color effectiveBg = widget.buttonBackgroundColor ?? scheme.primary;
    final Color effectiveFg = widget.buttonTextColor ?? (Get.isDarkMode ? scheme.onSurface : scheme.onPrimary);

    return SizedBox(
      height: kMinInteractiveDimension,
      width: double.infinity,
      child: GestureDetector(
        onTap: () async {
          HapticFeedback.lightImpact();
          _unfocus();
          _showShadow(true);
          await widget.onPressed?.call();
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
            transform: _showShadow.value ? Matrix4.identity() : Matrix4.translationValues(2, 2, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: widget.buttonBorderColor != null ? Border.all(color: widget.buttonBorderColor!) : null,
              color: effectiveBg,
              boxShadow: _showShadow.value
                  ? [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: effectiveBg.withOpacity(0.3),
                        offset: const Offset(4, 4),
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: widget.showLoader
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
                      strokeWidth: 2,
                    ),
                  )
                : widget.needIconButton
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (widget.iconButtonImage.isNotEmpty) ...[
                            Image.asset(
                              widget.iconButtonImage,
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                              color: widget.iconButtonColor ?? effectiveFg,
                            ),
                            8.w,
                          ],
                          Flexible(
                            child: AurumText.f16w600(
                              widget.text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              color: effectiveFg,
                            ),
                          ),
                        ],
                      )
                    : AurumText.f16w600(
                        widget.text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color: effectiveFg,
                      ),
          );
        }),
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
