import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aurum_widgets/src/utils/aurum_assets.dart';

enum AurumSocialType { google, apple, facebook, other }

/// A premium, brand-compliant social sign-in button.
/// Supports Google, Apple, and Facebook with automatic styling.
class AurumSocialButton extends StatelessWidget {
  final AurumSocialType type;
  final String? text;
  final VoidCallback onPressed;
  final bool fullWidth;
  final Widget? icon;

  const AurumSocialButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.text,
    this.fullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final String label = text ?? _getDefaultText();
    final Widget logo = icon ?? _getDefaultIcon();
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 56,
      child: OutlinedButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          onPressed();
        },
        style: OutlinedButton.styleFrom(
          // ignore: deprecated_member_use
          side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          foregroundColor: colorScheme.onSurface,
          backgroundColor: colorScheme.surface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDefaultText() {
    switch (type) {
      case AurumSocialType.google:
        return "Continue with Google";
      case AurumSocialType.apple:
        return "Continue with Apple";
      case AurumSocialType.facebook:
        return "Continue with Facebook";
      case AurumSocialType.other:
        return "Sign in";
    }
  }

  Widget _getDefaultIcon() {
    String path;
    switch (type) {
      case AurumSocialType.google:
        path = AurumAssetsImages().googleLogo;
        break;
      case AurumSocialType.apple:
        path = AurumAssetsImages().appleLogo;
        break;
      case AurumSocialType.facebook:
        path = AurumAssetsImages().facebookLogo;
        break;
      case AurumSocialType.other:
        return const Icon(Icons.login);
    }

    return Image.asset(
      path,
      height: 24,
      width: 24,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.account_circle_outlined, size: 24),
    );
  }
}
