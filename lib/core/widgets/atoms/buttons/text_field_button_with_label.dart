import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';

enum IconPosition { left, right, none }

typedef ValidatorFunction = String? Function(String value);

class ValidationBuilder {
  final List<ValidatorFunction> _validators = [];

  ValidationBuilder required([String message = 'This field is required']) {
    _validators.add((value) => value.trim().isEmpty ? message : null);
    return this;
  }

  ValidationBuilder minLength(int min, [String? message]) {
    _validators.add(
      (value) => value.trim().length < min
          ? (message ?? 'Minimum $min characters required')
          : null,
    );
    return this;
  }

  ValidationBuilder maxLength(int max, [String? message]) {
    _validators.add(
      (value) => value.trim().length > max
          ? (message ?? 'Maximum $max characters allowed')
          : null,
    );
    return this;
  }

  List<ValidatorFunction> build() => _validators;
}

// =============================================================================
// CONFIG CLASS FOR STYLING
// =============================================================================

class TextFieldButtonWithLabelConfig {
  const TextFieldButtonWithLabelConfig({
    // Card Properties
    required this.cardElevation,
    required this.cardBorderColor,
    required this.cardBackgroundColor,
    required this.cardBorderRadius,
    required this.cardPadding,

    // Label Properties
    required this.labelTextStyle,
    required this.labelSpacing,

    // TextField Properties
    required this.textFieldIconPosition,
    required this.textFieldTextStyle,
    required this.textFieldContentPadding,
    required this.textFieldSize,
    required this.textAlign,

    // Border Properties
    required this.focusedBorder,
    required this.unfocusedBorder,
    required this.fillColor,

    // Icon Properties
    required this.iconSize,
    required this.iconColor,
    required this.iconPadding,

    // Validation Properties
    required this.validationTextStyle,
    required this.validationSpacing,

    // Animation Properties
    required this.animationDuration,
  });

  /// Default config based on AppThemeData from context
  factory TextFieldButtonWithLabelConfig.defaultConfig(BuildContext context) {
    final theme = AppTheme.of(context);
    final fill = theme.fillColorScheme;
    final text = theme.textColorScheme;
    final border = theme.borderColorScheme;
    final surface = theme.surfaceColorScheme;
    final spacing = theme.spacing;
    final radius = theme.borderRadius;

    return TextFieldButtonWithLabelConfig(
      // Card Properties
      cardElevation: 0,
      cardBorderColor: border.primary,
      cardBackgroundColor: surface.layer02,
      cardBorderRadius: radius.m,
      cardPadding: EdgeInsets.all(spacing.l),

      // Label Properties
      labelTextStyle: theme.textStyle.labelLarge.standard(
        context: context,
        color: text.secondary,
      ),
      labelSpacing: spacing.s,

      // TextField Properties
      textFieldIconPosition: IconPosition.right,
      textFieldTextStyle: theme.textStyle.bodyLarge.standard(
        context: context,
        color: text.primary,
      ),
      textFieldContentPadding: EdgeInsets.symmetric(
        horizontal: spacing.l,
        vertical: spacing.m,
      ),
      textFieldSize: const Size(double.infinity, 48),
      textAlign: TextAlign.left,

      // Border Properties
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.m),
        borderSide: BorderSide(color: fill.themeThick, width: 2),
      ),
      unfocusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.m),
        borderSide: BorderSide(color: border.primary),
      ),
      fillColor: fill.primary,

      // Icon Properties
      iconSize: 20,
      iconColor: text.primary,
      iconPadding: EdgeInsets.only(right: spacing.m),

      // Validation Properties
      validationTextStyle: theme.textStyle.bodySmall.standard(
        context: context,
        color: text.error,
      ),
      validationSpacing: spacing.xs,

      // Animation Properties
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  // Card Properties
  /// Elevation of the card container
  final double cardElevation;

  /// Border color of the card container
  final Color cardBorderColor;

  /// Background color of the card container
  final Color cardBackgroundColor;

  /// Border radius of the card container
  final double cardBorderRadius;

  /// Padding inside the card container
  final EdgeInsetsGeometry cardPadding;

  // Label Properties
  /// Text style for the label above the text field
  final TextStyle labelTextStyle;

  /// Spacing between label and text field
  final double labelSpacing;

  // TextField Properties
  /// Position of the icon in the text field
  final IconPosition textFieldIconPosition;

  /// Text style for the text field content
  final TextStyle textFieldTextStyle;

  /// Content padding inside the text field
  final EdgeInsets textFieldContentPadding;

  /// Size constraints for the text field
  final Size textFieldSize;

  /// Text alignment within the text field
  final TextAlign textAlign;

  // Border Properties
  /// Border style when text field is focused
  final OutlineInputBorder focusedBorder;

  /// Border style when text field is not focused
  final OutlineInputBorder unfocusedBorder;

  /// Fill color for the text field background
  final Color fillColor;

  // Icon Properties
  /// Size of the icon
  final double iconSize;

  /// Color of the icon
  final Color iconColor;

  /// Padding around the icon
  final EdgeInsets iconPadding;

  // Validation Properties
  /// Text style for validation error messages
  final TextStyle validationTextStyle;

  /// Spacing between text field and validation message
  final double validationSpacing;

  // Animation Properties
  /// Duration for state transition animations
  final Duration animationDuration;
}

class TextFieldButtonWithLabel extends HookWidget {
  const TextFieldButtonWithLabel({
    required this.config,
    required this.labelText,
    required this.iconData,
    required this.startingText,
    required this.onTextSubmitted,
    this.validators,
    this.inputFormatters,
    this.tooltipText = '',
    super.key,
  });

  final TextFieldButtonWithLabelConfig config;
  final String labelText;
  final IconData iconData;
  final String startingText;
  final void Function(String) onTextSubmitted;
  final List<ValidatorFunction>? validators;
  final List<TextInputFormatter>? inputFormatters;
  final String tooltipText;

  @override
  Widget build(BuildContext context) {
    final isEditing = useState(false);
    final currentText = useState(startingText);
    final validationMessage = useState<String?>(null);
    final textController = useTextEditingController(text: currentText.value);
    final focusNode = useFocusNode();

    useEffect(
      () {
        currentText.value = startingText;
        textController.text = startingText;
        return null;
      },
      [startingText],
    );

    void handleTap() {
      if (!isEditing.value) {
        isEditing.value = true;
        textController.text = currentText.value;
        Future.delayed(const Duration(milliseconds: 100), focusNode.requestFocus);
      }
    }

    String? validate(String value) {
      if (validators == null || validators!.isEmpty) return null;
      for (final validator in validators!) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    }

    void handleSave() {
      final newText = textController.text.trim();
      final validation = validate(newText);
      if (validation != null) {
        validationMessage.value = validation;
        return;
      }
      validationMessage.value = null;
      if (newText != currentText.value) {
        currentText.value = newText;
        onTextSubmitted(newText);
      }
      isEditing.value = false;
      focusNode.unfocus();
    }

    final contentPadding = config.textFieldContentPadding;

    return AnimatedContainer(
      duration: config.animationDuration,
      child: Material(
        elevation: config.cardElevation,
        color: config.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.cardBorderRadius),
          side: BorderSide(color: config.cardBorderColor),
        ),
        child: Padding(
          padding: config.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (labelText.isNotEmpty) ...[
                Text(labelText, style: config.labelTextStyle),
                SizedBox(height: config.labelSpacing),
              ],
              Tooltip(
                message: tooltipText,
                child: SizedBox(
                  width: config.textFieldSize.width,
                  height: config.textFieldSize.height,
                  child: TextField(
                    controller: textController,
                    inputFormatters: inputFormatters,
                    focusNode: focusNode,
                    onTap: handleTap,
                    style: config.textFieldTextStyle,
                    textAlign: config.textAlign,
                    onEditingComplete: handleSave,
                    decoration: InputDecoration(
                      contentPadding: contentPadding,
                      enabledBorder: config.unfocusedBorder,
                      focusedBorder: config.focusedBorder,
                      filled: true,
                      fillColor: config.fillColor,
                      prefixIcon: config.textFieldIconPosition == IconPosition.left
                          ? Padding(
                              padding: config.iconPadding,
                              child: Icon(
                                iconData,
                                size: config.iconSize,
                                color: config.iconColor,
                              ),
                            )
                          : null,
                      suffixIcon: config.textFieldIconPosition == IconPosition.right
                          ? IconButton(
                              icon: Icon(
                                isEditing.value ? Icons.check : iconData,
                                size: config.iconSize,
                                color: config.iconColor,
                              ),
                              onPressed: isEditing.value ? handleSave : handleTap,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              if (validationMessage.value != null) ...[
                SizedBox(height: config.validationSpacing),
                Text(
                  validationMessage.value!,
                  style: config.validationTextStyle,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
