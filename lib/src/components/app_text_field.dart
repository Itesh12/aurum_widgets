import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "../utils/app_regex.dart";


class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.controller,
    required this.onTap,
    required this.focusNodeListener,
    this.autovalidateMode,
    this.hintText,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.prefixIconImage,
    this.suffixIconImage,
    this.obscureText,
    this.enabled,
    this.prefixIcon,
    this.suffixIcon,
    this.autofillHints,
    this.labelText,
    this.labelStyle,
    this.hintStyle,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.readOnly,
    this.textInputAction,
    this.textCapitalization,
    this.autofocus,
    this.needSmallTextSize = false,
    this.focusNode,
    this.minLines = 1,
    this.enableBorderColor,
    this.showCursor = true,
    this.onFieldSubmitted,
    this.hideErrorText = false,
    this.enableInteractiveSelection,
    this.contentPadding,
    this.textStyle,
    this.allowEmoji = false,
    this.floatingLabelBehavior,
    super.key,
  });

  final bool? autofocus;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final String? prefixIconImage;
  final String? suffixIconImage;
  final bool? obscureText;
  final num? maxLines;
  final num? maxLength;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final Iterable<String>? autofillHints;
  final String? labelText;
  final String? hintText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final void Function({required bool hasFocus}) focusNodeListener;
  final bool needSmallTextSize;
  final FocusNode? focusNode;
  final num minLines;
  final Color? enableBorderColor;
  final bool showCursor;
  final void Function(String)? onFieldSubmitted;
  final bool hideErrorText;
  final bool? enableInteractiveSelection;
  final TextStyle? textStyle;
  final bool allowEmoji;
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(listener);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(listener);
      focusNode.removeListener(listener);

      // If we created our own FocusNode and we are switching to a provided one (or vice versa),
      // we need to be careful about disposal of the internal one.
      // However, for simplicity and safety:
      focusNode = widget.focusNode ?? FocusNode();
      focusNode.addListener(listener);
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(listener);
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void listener() => widget.focusNodeListener(hasFocus: focusNode.hasFocus);

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Color primary = scheme.primary;
    final Color error = scheme.error;
    final Color borderColor = scheme.outline;
    final Color hintColor = widget.hintStyle?.color ?? scheme.outline;
    final Color disabledColor = Theme.of(context).disabledColor;

    return TextFormField(
      autovalidateMode: widget.autovalidateMode,
      autofocus: widget.autofocus ?? false,
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.none,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.words,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      readOnly: widget.readOnly ?? false,
      obscureText: widget.obscureText ?? false,
      minLines: widget.minLines.toInt(),
      maxLines: widget.maxLines?.toInt(),
      maxLength: widget.maxLength?.toInt(),
      onChanged: widget.onChanged,
      validator: widget.validator,
      onTap: widget.onTap,
      showCursor: widget.showCursor,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: <TextInputFormatter>[
        ...widget.inputFormatters ?? <TextInputFormatter>[],
        if (!widget.allowEmoji) ...[FilteringTextInputFormatter.deny(AppRegex().restrictEmojis)],
      ],
      enabled: widget.enabled ?? true,
      autofillHints: widget.autofillHints,
      decoration: InputDecoration(
        errorStyle: widget.hideErrorText ? const TextStyle(fontSize: 0, height: 0, color: Colors.transparent) : null,
        fillColor: Colors.white,
        contentPadding: widget.contentPadding,
        floatingLabelBehavior: widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ?? textTheme.bodyMedium?.copyWith(color: hintColor),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? textTheme.bodyMedium?.copyWith(color: hintColor),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> states) {
            final Color color = states.contains(WidgetState.focused) ? primary : scheme.outline;
            return TextStyle(color: color);
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: disabledColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.showCursor ? primary : borderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: error),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: error),
        ),
        prefixIcon: widget.prefixIcon ??
            (widget.prefixIconImage != null
                ? Align(
                    alignment: Alignment.centerLeft,
                    heightFactor: 1.0,
                    widthFactor: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Image.asset(
                        widget.prefixIconImage!,
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                        color: scheme.primary,
                      ),
                    ),
                  )
                : null),
        suffixIcon: widget.suffixIcon ??
            (widget.suffixIconImage != null
                ? Align(
                    alignment: Alignment.centerRight,
                    heightFactor: 1.0,
                    widthFactor: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        widget.suffixIconImage ?? "",
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                        color: scheme.primary,
                      ),
                    ),
                  )
                : null),
        counterText: "",
      ),
      cursorColor: primary,
      cursorErrorColor: error,
      focusNode: focusNode,
      enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
      style: widget.textStyle ??
          (widget.needSmallTextSize ? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500) : const TextStyle()),
    );
  }
}
