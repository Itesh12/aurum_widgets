import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A premium, transparent text button with built-in haptic feedback.
/// Used for secondary actions like "Skip", "Forgot Password", or "Resend".
class AurumTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;
  final bool useHaptics;

  const AurumTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.useHaptics = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return TextButton(
      onPressed: onPressed != null
          ? () {
              if (useHaptics) {
                HapticFeedback.lightImpact();
              }
              onPressed?.call();
            }
          : null,
      style: TextButton.styleFrom(
        padding: padding,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: style ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
      ),
    );
  }
}
