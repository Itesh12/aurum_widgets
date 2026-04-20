import "package:flutter/material.dart";
import "app_text.dart";
import "package:marquee/marquee.dart";

class AppMaybeMarqueeText extends StatelessWidget {
  const AppMaybeMarqueeText({
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.infoIconAlign = false,
    super.key,
  });

  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final bool infoIconAlign;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color defaultColor = theme.textTheme.bodyMedium?.color ?? Colors.black;

    // Merge provided style with theme
    final TextStyle effectiveStyle = (style ?? const TextStyle()).copyWith(
      color: style?.color ?? defaultColor,
    );

    return infoIconAlign
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool hasBoundedWidth = constraints.maxWidth != double.infinity;

              final double maxWidth = hasBoundedWidth ? constraints.maxWidth : 200;

              final bool needsMarquee = _overflowing(
                context: context,
                maxWidth: maxWidth,
                style: effectiveStyle,
              );

              if (needsMarquee && hasBoundedWidth) {
                return SizedBox(
                  height: _fontSize(context: context, style: effectiveStyle),
                  width: maxWidth,
                  child: Marquee(
                    text: text,
                    style: effectiveStyle,
                    blankSpace: maxWidth / 3,
                    pauseAfterRound: const Duration(seconds: 3),
                    startAfter: const Duration(seconds: 1),
                    velocity: 30,
                  ),
                );
              }

              return AppText(
                text: text,
                fontSize: effectiveStyle.fontSize ?? 16,
                fontWeight: effectiveStyle.fontWeight ?? FontWeight.w600,
                color: effectiveStyle.color,
                maxLines: maxLines ?? 1,
                overflow: overflow ?? TextOverflow.ellipsis,
                textAlign: textAlign,
              );
            },
          )
        : SizedBox(
            height: _fontSize(context: context, style: effectiveStyle),
            width: double.infinity,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool needsMarquee = _overflowing(
                  context: context,
                  maxWidth: constraints.maxWidth,
                  style: effectiveStyle,
                );

                if (needsMarquee) {
                  return Marquee(
                    text: text,
                    style: effectiveStyle,
                    blankSpace: constraints.maxWidth / 3,
                    pauseAfterRound: const Duration(seconds: 3),
                    showFadingOnlyWhenScrolling: false,
                    startAfter: const Duration(seconds: 1),
                    velocity: 30,
                  );
                }

                return AppText(
                  text: text,
                  fontSize: effectiveStyle.fontSize ?? 16,
                  fontWeight: effectiveStyle.fontWeight ?? FontWeight.w600,
                  color: effectiveStyle.color,
                  maxLines: maxLines ?? 1,
                  overflow: overflow ?? TextOverflow.ellipsis,
                  textAlign: textAlign,
                  height: effectiveStyle.height,
                  letterSpacing: effectiveStyle.letterSpacing,
                  decoration: effectiveStyle.decoration,
                );
              },
            ),
          );
  }

  bool _overflowing({
    required BuildContext context,
    required double maxWidth,
    required TextStyle style,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 16);

    return textPainter.didExceedMaxLines;
  }

  double _fontSize({
    required BuildContext context,
    required TextStyle style,
  }) {
    final double fontSize = style.fontSize ?? DefaultTextStyle.of(context).style.fontSize ?? 14.0;
    final double height = style.height ?? DefaultTextStyle.of(context).style.height ?? 1.2;

    return fontSize * height;
  }
}
