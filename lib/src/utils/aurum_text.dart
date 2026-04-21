import "package:flutter/material.dart";

class AurumText extends StatelessWidget {
  const AurumText({
    required this.text,
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  });

  /// Font Size: 12 Font Weight 400,500,600
  factory AurumText.f12w400(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  factory AurumText.f12w500(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  factory AurumText.f12w600(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  /// Font Size: 14 Font Weight 400,500,600
  factory AurumText.f14w400(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  factory AurumText.f14w500(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  factory AurumText.f14w600(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  /// Font Size: 16 Font Weight 400,500,600
  factory AurumText.f16w400(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  factory AurumText.f16w500(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  factory AurumText.f16w600(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  /// Font Size: 18 Font Weight 400,500,600
  factory AurumText.f18w400(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  factory AurumText.f18w500(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  factory AurumText.f18w600(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }
  factory AurumText.f20w600(
    final String text, {
    final Color? color,
    TextAlign? textAlign,
    final int? maxLines,
    final TextOverflow? overflow,
    final TextDecoration? decoration,
    final double? letterSpacing,
  }) {
    return AurumText(
      text: text,
      color: color,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      textAlign: textAlign,
      overflow: overflow,
      decoration: decoration,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
    );
  }

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.visible,
      style: TextStyle(
        color: color ?? theme.textTheme.bodyMedium?.color,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        decoration: decoration,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
