import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

class TextFieldButtonWithLabelConfig {
  const TextFieldButtonWithLabelConfig({
    required this.cardElevation,
    required this.cardBorderColor,
    required this.cardBackgroundColor,
    required this.cardBorderRadius,
    required this.labelTextStyle,
    required this.textFieldIconPosition,
    required this.textFieldTextStyle,
    required this.textFieldContentPadding,
    required this.focusedBorder,
    required this.unfocusedBorder,
    required this.textFieldSize,
    required this.textAlign,
    required this.iconSize,
    required this.iconColor,
    required this.iconPadding,
    this.validationTextStyle,
  });

  factory TextFieldButtonWithLabelConfig.defaultConfig() {
    return TextFieldButtonWithLabelConfig(
      cardElevation: 0,
      cardBorderColor: Colors.grey.shade700,
      cardBackgroundColor: Colors.grey.shade900,
      cardBorderRadius: 8,
      labelTextStyle: const TextStyle(
        fontSize: 14,
        color: UIConfig.topBarSecondaryTextColor,
        letterSpacing: .7,
      ),
      textFieldIconPosition: IconPosition.right,
      textFieldTextStyle: const TextStyle(
        fontSize: 18,
        color: UIConfig.topBarPrimaryTextColor,
        letterSpacing: 0.8,
      ),
      textFieldContentPadding: EdgeInsets.zero,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
      unfocusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade900),
      ),
      textFieldSize: const Size(double.infinity, 48),
      textAlign: TextAlign.left,
      iconSize: 16,
      iconColor: Colors.white,
      iconPadding: const EdgeInsets.only(left: 55),
      validationTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.redAccent,
      ),
    );
  }

  final double cardElevation;
  final Color cardBorderColor;
  final Color cardBackgroundColor;
  final double cardBorderRadius;

  final TextStyle labelTextStyle;

  final IconPosition textFieldIconPosition;
  final TextStyle textFieldTextStyle;
  final EdgeInsets textFieldContentPadding;

  final OutlineInputBorder focusedBorder;
  final OutlineInputBorder unfocusedBorder;

  final Size textFieldSize;
  final TextAlign textAlign;

  final double iconSize;
  final Color iconColor;
  final EdgeInsets iconPadding;

  final TextStyle? validationTextStyle;
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

    useEffect(() {
  currentText.value = startingText;
  textController.text = startingText;
  return null;
}, [startingText],);


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

    final contentPadding = isEditing.value
        ? (config.textFieldContentPadding.left < 8
            ? config.textFieldContentPadding.copyWith(left: 8)
            : config.textFieldContentPadding)
        : config.textFieldContentPadding;

    return Material(
      elevation: config.cardElevation,
      color: config.cardBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(config.cardBorderRadius),
        side: BorderSide(color: config.cardBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (labelText.isNotEmpty) Text(labelText, style: config.labelTextStyle),
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
                    fillColor: config.cardBackgroundColor,
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
            if (validationMessage.value != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  validationMessage.value!,
                  style: config.validationTextStyle ??
                      const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
