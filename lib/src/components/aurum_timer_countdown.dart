import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

/// A styled timer countdown widget for "Resend OTP" flows.
/// Matches the Aurum design system with clean typography.
class AurumTimerCountdown extends StatelessWidget {
  final DateTime endTime;
  final VoidCallback? onEnd;
  final String prefixText;
  final TextStyle? textStyle;
  final TextStyle? timerStyle;

  const AurumTimerCountdown({
    super.key,
    required this.endTime,
    this.onEnd,
    this.prefixText = "Resend OTP in: ",
    this.textStyle,
    this.timerStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prefixText,
          style: textStyle ??
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
        ),
        TimerCountdown(
          endTime: endTime,
          onEnd: onEnd,
          format: CountDownTimerFormat.minutesSeconds,
          spacerWidth: 4,
          enableDescriptions: false,
          timeTextStyle: timerStyle ??
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
          colonsTextStyle: timerStyle ??
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
        ),
      ],
    );
  }
}
