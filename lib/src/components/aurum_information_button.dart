import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A small information icon button used for tooltips or "Help" indicators.
/// Frequently seen next to section headers in authentication flows.
class AurumInformationButton extends StatelessWidget {
  final String? message;
  final VoidCallback? onTap;
  final double size;
  final Color? color;

  const AurumInformationButton({
    super.key,
    this.message,
    this.onTap,
    this.size = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      child: Tooltip(
        message: message ?? "Information",
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontSize: 12,
        ),
        triggerMode: TooltipTriggerMode.tap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.info_outline,
            size: size,
            color: color ?? Theme.of(context).hintColor,
          ),
        ),
      ),
    );
  }
}
