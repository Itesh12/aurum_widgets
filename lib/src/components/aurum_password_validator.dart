import 'package:flutter/material.dart';

/// A premium password strength and requirement indicator.
/// Shows which criteria (length, uppercase, digits, etc.) are met.
class AurumPasswordValidator extends StatelessWidget {
  final String password;
  final int minLength;
  final bool requireUppercase;
  final bool requireLowercase;
  final bool requireDigit;
  final bool requireSpecialChar;

  const AurumPasswordValidator({
    super.key,
    required this.password,
    this.minLength = 8,
    this.requireUppercase = true,
    this.requireLowercase = true,
    this.requireDigit = true,
    this.requireSpecialChar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRequirementRow(
          context,
          "At least $minLength characters",
          password.length >= minLength,
        ),
        if (requireUppercase)
          _buildRequirementRow(
            context,
            "One uppercase letter",
            password.contains(RegExp(r'[A-Z]')),
          ),
        if (requireLowercase)
          _buildRequirementRow(
            context,
            "One lowercase letter",
            password.contains(RegExp(r'[a-z]')),
          ),
        if (requireDigit)
          _buildRequirementRow(
            context,
            "One digit",
            password.contains(RegExp(r'[0-9]')),
          ),
        if (requireSpecialChar)
          _buildRequirementRow(
            context,
            "One special character",
            password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
          ),
      ],
    );
  }

  Widget _buildRequirementRow(BuildContext context, String requirement, bool isMet) {
    final Color color = isMet ? Colors.green : Theme.of(context).hintColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle_rounded : Icons.circle_outlined,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            requirement,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: isMet ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
