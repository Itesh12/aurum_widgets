import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "../utils/aurum_regex.dart";
import "../utils/aurum_assets.dart";


/// A highly customizable text field with support for icons, validation, 
/// and a special [dropdownField] mode.
///
/// Use [dropdownField] true to make the field read-only and show a dropdown arrow.
class AurumTextField extends StatefulWidget {
  const AurumTextField({
    required this.controller,
    required this.onTap,
    this.focusNodeListener,
    this.dropdownField = false,
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

  /// Whether to autofocus the field on load.
  final bool? autofocus;

  /// The controller for the text being edited.
  final TextEditingController controller;

  /// The type of information for which to optimize the text input control.
  final TextInputType? keyboardType;

  /// Configures how the field validates itself.
  final AutovalidateMode? autovalidateMode;

  /// Configures how the text should be capitalized.
  final TextCapitalization? textCapitalization;

  /// The action the user takes when they finish entering text in the field.
  final TextInputAction? textInputAction;

  /// Whether the field is read-only.
  final bool? readOnly;

  /// An image path to show as a prefix icon.
  final String? prefixIconImage;

  /// An image path to show as a suffix icon.
  final String? suffixIconImage;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool? obscureText;

  /// The maximum number of lines for the field.
  final num? maxLines;

  /// The maximum number of characters allowed.
  final num? maxLength;

  /// Called when the text being edited changes.
  final void Function(String)? onChanged;

  /// A function that takes the current value and returns an error string if invalid.
  final String? Function(String?)? validator;

  /// Called when the user taps on the text field.
  final void Function()? onTap;

  /// Optional input formatters to apply during editing.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the field is enabled.
  final bool? enabled;

  /// Hints for the platform's autofill service.
  final Iterable<String>? autofillHints;

  /// Text that describes the input field.
  final String? labelText;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Custom style for the label text.
  final TextStyle? labelStyle;

  /// Custom style for the hint text.
  final TextStyle? hintStyle;

  /// A custom widget to show as a prefix icon.
  final Widget? prefixIcon;

  /// A custom widget to show as a suffix icon.
  final Widget? suffixIcon;

  /// Optional padding around the content.
  final EdgeInsets? contentPadding;

  /// A callback that provides focus status updates.
  final void Function({required bool hasFocus})? focusNodeListener;

  /// Whether to use slightly smaller text sizes.
  final bool needSmallTextSize;

  /// An optional focus node to use.
  final FocusNode? focusNode;

  /// The minimum number of lines for the field.
  final num minLines;

  /// The color of the border when the field is enabled.
  final Color? enableBorderColor;

  /// Whether to show the cursor.
  final bool showCursor;

  /// Called when the user submits the field (e.g., presses "Done" on keyboard).
  final void Function(String)? onFieldSubmitted;

  /// Whether to hide the error text even if validation fails.
  final bool hideErrorText;

  /// Whether to enable interactive selection (copy/paste).
  final bool? enableInteractiveSelection;

  /// Custom text style for the input.
  final TextStyle? textStyle;

  /// Whether to allow emojis in the input.
  final bool allowEmoji;

  /// When true, makes the field read-only and automatically shows a dropdown icon.
  final bool dropdownField;

  /// Configures the behavior of the floating label.
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  State<AurumTextField> createState() => _AurumTextFieldState();
}

class _AurumTextFieldState extends State<AurumTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(listener);
  }

  @override
  void didUpdateWidget(covariant AurumTextField oldWidget) {
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

  void listener() => widget.focusNodeListener?.call(hasFocus: focusNode.hasFocus);

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
      readOnly: widget.dropdownField ? true : (widget.readOnly ?? false),
      obscureText: widget.obscureText ?? false,
      minLines: widget.minLines.toInt(),
      maxLines: widget.maxLines?.toInt(),
      maxLength: widget.maxLength?.toInt(),
      onChanged: widget.onChanged,
      validator: widget.validator,
      onTap: () {
        if (widget.dropdownField) {
          HapticFeedback.lightImpact();
        }
        widget.onTap?.call();
      },
      showCursor: widget.dropdownField ? false : (widget.showCursor),
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: <TextInputFormatter>[
        ...?widget.inputFormatters,
        if (!widget.allowEmoji) ...[FilteringTextInputFormatter.deny(AurumRegex().restrictEmojis)],
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
            ((widget.suffixIconImage != null || widget.dropdownField)
                ? Align(
                    alignment: Alignment.centerRight,
                    heightFactor: 1.0,
                    widthFactor: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        widget.suffixIconImage ?? (widget.dropdownField ? AurumAssetsImages().downArrowIcon : ""),
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                        color: scheme.primary,
                        package: 'aurum_widgets',
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
