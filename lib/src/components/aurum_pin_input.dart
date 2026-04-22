import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

/// A premium OTP/Pin input widget using the 'pinput' package.
/// Styled to match the Aurum design system with rounded borders and clear focus states.
class AurumPinInput extends StatelessWidget {
  final int length;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final FormFieldValidator<String>? validator;
  final bool autofocus;

  const AurumPinInput({
    super.key,
    this.length = 6,
    this.controller,
    this.onChanged,
    this.onCompleted,
    this.validator,
    this.autofocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // ignore: deprecated_member_use
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: colorScheme.surface,
      border: Border.all(color: colorScheme.primary, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: colorScheme.surface,
      ),
    );

    return Pinput(
      length: length,
      controller: controller,
      autofocus: autofocus,
      onChanged: onChanged,
      onCompleted: (value) {
        HapticFeedback.mediumImpact();
        onCompleted?.call(value);
      },
      validator: validator,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      autofillHints: const [AutofillHints.oneTimeCode],
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 2,
            color: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
