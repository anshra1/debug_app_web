import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum IconPosition { left, right, none }

class TextFieldButtonWithLabelConfig {
  const TextFieldButtonWithLabelConfig({
    required this.cardContentPadding,
    required this.cardElevation,
    required this.cardBorderColor,
    required this.cardBackgroundColor,
    required this.cardBorderRadius,
    required this.labelText,
    required this.labelTextStyle,
    required this.textFieldIconPosition,
    required this.textFieldTextStyle,
    required this.textFieldContentPadding,
    required this.focusedBorderWidth,
    required this.focusedBorderColor,
    required this.focusedBackgroundColor,
    required this.focusedTextColor,
    required this.focusedBorderRadius,
    required this.unfocusedBorderWidth,
    required this.unfocusedBorderColor,
    required this.unfocusedBackgroundColor,
    required this.unfocusedTextColor,
    required this.unfocusedBorderRadius,
    this.textFieldIcon,
    this.textFieldSize,
    this.textAlign = TextAlign.left,
  });
  // === Card ===
  final EdgeInsets cardContentPadding;
  final double cardElevation;
  final Color cardBorderColor;
  final Color cardBackgroundColor;
  final double cardBorderRadius;

  // === Label ===
  final String labelText;
  final TextStyle labelTextStyle;

  // === TextField ===
  final IconPosition textFieldIconPosition;
  final TextStyle textFieldTextStyle;
  final EdgeInsets textFieldContentPadding;
  final double focusedBorderWidth;
  final Color focusedBorderColor;
  final Color focusedBackgroundColor;
  final Color focusedTextColor;
  final double focusedBorderRadius;
  final double unfocusedBorderWidth;
  final Color unfocusedBorderColor;
  final Color unfocusedBackgroundColor;
  final Color unfocusedTextColor;
  final double unfocusedBorderRadius;
  final Icon? textFieldIcon;
  final Size? textFieldSize;
  final TextAlign textAlign;
}

class TextFieldButtonWithLabel extends HookWidget {
  const TextFieldButtonWithLabel({
    required this.startingText,
    required this.config,
    required this.onSubmittedText,
    super.key,
    this.tooltipText = '',
  });

  final String startingText;
  final TextFieldButtonWithLabelConfig config;
  final void Function(String) onSubmittedText;
  final String tooltipText;

  @override
  Widget build(BuildContext context) {
    final isEditing = useState(false);
    final currentText = useState(startingText);
    final textController = useTextEditingController(text: currentText.value);
    final focusNode = useFocusNode();

    // Enter edit mode
    void handleTap() {
      isEditing.value = true;
      textController.text = currentText.value;
      Future.delayed(const Duration(milliseconds: 100), focusNode.requestFocus);
    }

    // Save and exit edit mode
    void handleSubmit() {
      final newText = textController.text.trim();
      if (newText.isNotEmpty && newText != currentText.value) {
        currentText.value = newText;
        onSubmittedText(newText);
      }
      isEditing.value = false;
      focusNode.unfocus();
    }

    // Sync controller if external text changes
    useEffect(() {
      textController.text = currentText.value;
      return null;
    }, [
      currentText.value,
    ]);

    return Padding(
      padding: config.cardContentPadding,
      child: Material(
        elevation: config.cardElevation,
        color: config.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.cardBorderRadius),
          side: BorderSide(color: config.cardBorderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (config.labelText.isNotEmpty) ...[
                Text(config.labelText, style: config.labelTextStyle),
                const SizedBox(height: 12),
              ],
              Tooltip(
                message: tooltipText,
                child: SizedBox(
                  width: config.textFieldSize?.width ?? double.infinity,
                  height: config.textFieldSize?.height ?? 48,
                  child: TextField(
                    controller: textController,
                    focusNode: focusNode,
                    style: config.textFieldTextStyle.copyWith(
                      color: isEditing.value
                          ? config.focusedTextColor
                          : config.unfocusedTextColor,
                    ),
                    textAlign: config.textAlign,
                    readOnly: !isEditing.value,
                    onSubmitted: (_) => handleSubmit(),
                    onTap: !isEditing.value ? handleTap : null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(config.unfocusedBorderRadius),
                        borderSide: BorderSide(
                          color: config.unfocusedBorderColor,
                          width: config.unfocusedBorderWidth,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(config.focusedBorderRadius),
                        borderSide: BorderSide(
                          color: config.focusedBorderColor,
                          width: config.focusedBorderWidth,
                        ),
                      ),
                      contentPadding: config.textFieldContentPadding,
                      filled: true,
                      fillColor: isEditing.value
                          ? config.focusedBackgroundColor
                          : config.unfocusedBackgroundColor,
                      prefixIcon: config.textFieldIconPosition == IconPosition.left &&
                              config.textFieldIcon != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 12, right: 8),
                              child: config.textFieldIcon,
                            )
                          : null,
                      suffixIcon: config.textFieldIconPosition == IconPosition.right &&
                              config.textFieldIcon != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8, right: 12),
                              child: config.textFieldIcon,
                            )
                          : null,
                      prefixIconConstraints: const BoxConstraints(),
                      suffixIconConstraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
