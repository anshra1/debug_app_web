import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';

// =============================================================================
// CONFIG CLASS FOR STYLING
// =============================================================================

/// Configuration class for AppDropdownWidget that encapsulates all visual
/// properties and layout rules, including per-state styling for hover,
/// selected, disabled, and focused states.
///
/// This config follows production-grade design system patterns and ensures
/// consistent styling across all dropdown instances.
class AppDropdownWidgetConfig {
  const AppDropdownWidgetConfig({
    // Layout Properties
    required this.padding,
    required this.borderRadius,
    required this.spacing,
    required this.iconSize,
    required this.clearIconSize,
    required this.overlaySpacing,
    required this.overlayPadding,
    required this.itemPadding,
    required this.labelSpacing,
    required this.errorSpacing,

    // Button Colors - Normal State
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.hintTextColor,
    required this.iconColor,

    // Button Colors - Hover State
    required this.hoverBackgroundColor,
    required this.hoverBorderColor,
    required this.hoverTextColor,
    required this.hoverIconColor,

    // Button Colors - Open State
    required this.openBackgroundColor,
    required this.openBorderColor,
    required this.openTextColor,
    required this.openIconColor,

    // Button Colors - Disabled State
    required this.disabledBackgroundColor,
    required this.disabledBorderColor,
    required this.disabledTextColor,
    required this.disabledIconColor,

    // Button Colors - Focused State
    required this.focusedBorderColor,
    required this.focusRingColor,

    // Overlay Colors
    required this.overlayBackgroundColor,
    required this.overlayBorderColor,
    required this.overlayShadowColor,

    // Menu Item Colors - Normal State
    required this.itemBackgroundColor,
    required this.itemTextColor,
    required this.itemIconColor,

    // Menu Item Colors - Hover State
    required this.itemHoverBackgroundColor,
    required this.itemHoverTextColor,
    required this.itemHoverIconColor,

    // Menu Item Colors - Selected State
    required this.itemSelectedBackgroundColor,
    required this.itemSelectedTextColor,
    required this.itemSelectedIconColor,

    // Label and Error Colors
    required this.labelTextColor,
    required this.requiredTextColor,
    required this.errorTextColor,

    // Text Styles
    required this.textStyleNormal,
    required this.textStyleHover,
    required this.textStyleOpen,
    required this.textStyleDisabled,
    required this.hintTextStyle,
    required this.labelTextStyle,
    required this.errorTextStyle,
    required this.itemTextStyleNormal,
    required this.itemTextStyleHover,
    required this.itemTextStyleSelected,

    // Border Widths
    required this.borderWidth,
    required this.borderWidthOpen,
    required this.borderWidthFocused,

    // Animation
    required this.animationDuration,
    required this.animationCurve,

    // Overlay Properties
    required this.overlayElevation,
    required this.overlayBorderRadius,
    required this.itemBorderRadius,
  });

  /// Creates a default configuration based on the current app theme.
  ///
  /// Sources all styling values from AppTheme.of(context) to ensure
  /// consistency with the app's design system and user preferences.
  factory AppDropdownWidgetConfig.defaultConfig(BuildContext context) {
    final theme = AppTheme.of(context);
    final fill = theme.fillColorScheme;
    final text = theme.textColorScheme;
    final border = theme.borderColorScheme;
    final icon = theme.iconColorScheme;
    final surface = theme.surfaceColorScheme;

    return AppDropdownWidgetConfig(
      // Layout Properties
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.m,
        vertical: theme.spacing.s,
      ),
      borderRadius: theme.borderRadius.m,
      spacing: theme.spacing.s,
      iconSize: 20,
      clearIconSize: 16,
      overlaySpacing: 4,
      overlayPadding: EdgeInsets.all(theme.spacing.xs),
      itemPadding: EdgeInsets.symmetric(
        horizontal: theme.spacing.m,
        vertical: theme.spacing.s,
      ),
      labelSpacing: theme.spacing.xs,
      errorSpacing: theme.spacing.xs,

      // Button Colors - Normal State
      backgroundColor: fill.primary,
      borderColor: border.primary,
      textColor: text.primary,
      hintTextColor: text.tertiary,
      iconColor: icon.primary,

      // Button Colors - Hover State
      hoverBackgroundColor: fill.primaryHover,
      hoverBorderColor: border.primaryHover,
      hoverTextColor: text.primary,
      hoverIconColor: icon.primary,

      // Button Colors - Open State
      openBackgroundColor: fill.primary,
      openBorderColor: border.themeThick,
      openTextColor: text.primary,
      openIconColor: icon.primary,

      // Button Colors - Disabled State
      disabledBackgroundColor: fill.quaternary,
      disabledBorderColor: border.tertiary,
      disabledTextColor: text.quaternary,
      disabledIconColor: icon.quaternary,

      // Button Colors - Focused State
      focusedBorderColor: border.themeThick,
      focusRingColor: fill.themeThick,

      // Overlay Colors
      overlayBackgroundColor: surface.layer01,
      overlayBorderColor: border.primary,
      overlayShadowColor: Colors.black.withOpacity(0.1),

      // Menu Item Colors - Normal State
      itemBackgroundColor: Colors.transparent,
      itemTextColor: text.primary,
      itemIconColor: icon.primary,

      // Menu Item Colors - Hover State
      itemHoverBackgroundColor: fill.primaryHover,
      itemHoverTextColor: text.primary,
      itemHoverIconColor: icon.primary,

      // Menu Item Colors - Selected State
      itemSelectedBackgroundColor: fill.themeSelect,
      itemSelectedTextColor: text.primary,
      itemSelectedIconColor: icon.primary,

      // Label and Error Colors
      labelTextColor: text.primary,
      requiredTextColor: text.error,
      errorTextColor: text.error,

      // Text Styles
      textStyleNormal: theme.textStyle.bodyMedium.standard(
        context: context,
        color: text.primary,
      ),
      textStyleHover: theme.textStyle.bodyMedium.standard(
        context: context,
        color: text.primary,
      ),
      textStyleOpen: theme.textStyle.bodyMedium.standard(
        context: context,
        color: text.primary,
      ),
      textStyleDisabled: theme.textStyle.bodyMedium.standard(
        context: context,
        color: text.quaternary,
      ),
      hintTextStyle: theme.textStyle.bodyMedium.standard(
        context: context,
        color: text.tertiary,
      ),
      labelTextStyle: theme.textStyle.labelMedium.standard(
        context: context,
        color: text.primary,
      ),
      errorTextStyle: theme.textStyle.bodySmall.standard(
        context: context,
        color: text.error,
      ),
      itemTextStyleNormal: theme.textStyle.bodyMedium.standard(
        context: context,
        color: text.primary,
      ),
      itemTextStyleHover: theme.textStyle.bodyMedium.standard(
        context: context,
        color: text.primary,
      ),
      itemTextStyleSelected: theme.textStyle.bodyMedium.standard(
        context: context,
        color: text.primary,
      ),

      // Border Widths
      borderWidth: 1,
      borderWidthOpen: 2,
      borderWidthFocused: 2,

      // Animation
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,

      // Overlay Properties
      overlayElevation: 8,
      overlayBorderRadius: theme.borderRadius.m,
      itemBorderRadius: theme.borderRadius.s,
    );
  }

  // ==========================================================================
  // LAYOUT PROPERTIES
  // ==========================================================================

  /// Internal padding for the dropdown button content.
  /// Affects the space around text, icons, and other button elements.
  final EdgeInsetsGeometry padding;

  /// Border radius for the dropdown button and focus ring.
  /// Controls the roundness of the button corners.
  final double borderRadius;

  /// Spacing between internal elements (icon and text).
  /// Controls the gap between the leading icon, text, clear button, and dropdown arrow.
  final double spacing;

  /// Size of the main dropdown arrow icon.
  /// Affects both the dropdown arrow and any leading icons.
  final double iconSize;

  /// Size of the clear button icon when showClearButton is true.
  /// Smaller than iconSize for better visual hierarchy.
  final double clearIconSize;

  /// Vertical spacing between the dropdown button and overlay menu.
  /// Controls how far the menu appears below the button.
  final double overlaySpacing;

  /// Internal padding for the dropdown overlay menu container.
  /// Affects the space around the menu items list.
  final EdgeInsetsGeometry overlayPadding;

  /// Internal padding for individual menu items.
  /// Controls the clickable area and text spacing within each menu option.
  final EdgeInsetsGeometry itemPadding;

  /// Spacing between the label and the dropdown button.
  /// Only applies when a label is provided.
  final double labelSpacing;

  /// Spacing between the dropdown button and error text.
  /// Only applies when errorText is provided.
  final double errorSpacing;

  // ==========================================================================
  // BUTTON COLORS - NORMAL STATE
  // ==========================================================================

  /// Background color when the dropdown is in its default, uninteracted state.
  final Color backgroundColor;

  /// Border color when the dropdown is in its default, uninteracted state.
  final Color borderColor;

  /// Text color for selected value when in normal state.
  final Color textColor;

  /// Text color for the hint/placeholder text when no value is selected.
  final Color hintTextColor;

  /// Color for icons (dropdown arrow, leading icon) in normal state.
  final Color iconColor;

  // ==========================================================================
  // BUTTON COLORS - HOVER STATE
  // ==========================================================================

  /// Background color when the dropdown button is being hovered.
  /// Provides visual feedback for mouse interaction.
  final Color hoverBackgroundColor;

  /// Border color when the dropdown button is being hovered.
  /// Usually slightly different from normal state for subtle feedback.
  final Color hoverBorderColor;

  /// Text color when the dropdown button is being hovered.
  final Color hoverTextColor;

  /// Icon color when the dropdown button is being hovered.
  final Color hoverIconColor;

  // ==========================================================================
  // BUTTON COLORS - OPEN STATE
  // ==========================================================================

  /// Background color when the dropdown menu is open/expanded.
  /// Indicates the active state of the dropdown.
  final Color openBackgroundColor;

  /// Border color when the dropdown menu is open/expanded.
  /// Often uses theme accent color to show active state.
  final Color openBorderColor;

  /// Text color when the dropdown menu is open/expanded.
  final Color openTextColor;

  /// Icon color when the dropdown menu is open/expanded.
  final Color openIconColor;

  // ==========================================================================
  // BUTTON COLORS - DISABLED STATE
  // ==========================================================================

  /// Background color when the dropdown is disabled (enabled: false).
  /// Usually a muted/grayed out appearance.
  final Color disabledBackgroundColor;

  /// Border color when the dropdown is disabled.
  /// Typically uses muted colors to indicate non-interactive state.
  final Color disabledBorderColor;

  /// Text color when the dropdown is disabled.
  /// Should have reduced contrast to indicate disabled state.
  final Color disabledTextColor;

  /// Icon color when the dropdown is disabled.
  final Color disabledIconColor;

  // ==========================================================================
  // BUTTON COLORS - FOCUSED STATE
  // ==========================================================================

  /// Border color when the dropdown has keyboard focus.
  /// Used for accessibility and keyboard navigation.
  final Color focusedBorderColor;

  /// Color of the outer focus ring that appears around the button when focused.
  /// Provides clear visual indication of keyboard focus for accessibility.
  final Color focusRingColor;

  // ==========================================================================
  // OVERLAY COLORS
  // ==========================================================================

  /// Background color of the dropdown menu overlay.
  /// Should contrast well with menu items for readability.
  final Color overlayBackgroundColor;

  /// Border color of the dropdown menu overlay container.
  final Color overlayBorderColor;

  /// Shadow color for the dropdown menu elevation.
  /// Provides depth and separation from the background.
  final Color overlayShadowColor;

  // ==========================================================================
  // MENU ITEM COLORS - NORMAL STATE
  // ==========================================================================

  /// Background color for menu items in their default state.
  /// Usually transparent to blend with overlay background.
  final Color itemBackgroundColor;

  /// Text color for menu items in their default state.
  final Color itemTextColor;

  /// Icon color for the checkmark on selected menu items in normal state.
  final Color itemIconColor;

  // ==========================================================================
  // MENU ITEM COLORS - HOVER STATE
  // ==========================================================================

  /// Background color when a menu item is being hovered.
  /// Provides immediate visual feedback for mouse interaction.
  final Color itemHoverBackgroundColor;

  /// Text color when a menu item is being hovered.
  final Color itemHoverTextColor;

  /// Icon color when a menu item is being hovered.
  final Color itemHoverIconColor;

  // ==========================================================================
  // MENU ITEM COLORS - SELECTED STATE
  // ==========================================================================

  /// Background color for the currently selected menu item.
  /// Indicates which option corresponds to the current dropdown value.
  final Color itemSelectedBackgroundColor;

  /// Text color for the currently selected menu item.
  final Color itemSelectedTextColor;

  /// Icon color for the checkmark on the currently selected menu item.
  final Color itemSelectedIconColor;

  // ==========================================================================
  // LABEL AND ERROR COLORS
  // ==========================================================================

  /// Text color for the dropdown label.
  final Color labelTextColor;

  /// Text color for the required asterisk (*) when isRequired is true.
  final Color requiredTextColor;

  /// Text color for error messages displayed below the dropdown.
  final Color errorTextColor;

  // ==========================================================================
  // TEXT STYLES PER STATE
  // ==========================================================================

  /// Text style for the selected value when in normal state.
  final TextStyle textStyleNormal;

  /// Text style for the selected value when the button is hovered.
  final TextStyle textStyleHover;

  /// Text style for the selected value when the dropdown is open.
  final TextStyle textStyleOpen;

  /// Text style for the selected value when the dropdown is disabled.
  /// Should have reduced opacity or muted appearance.
  final TextStyle textStyleDisabled;

  /// Text style for the hint/placeholder text when no value is selected.
  final TextStyle hintTextStyle;

  /// Text style for the dropdown label text.
  final TextStyle labelTextStyle;

  /// Text style for error messages displayed below the dropdown.
  final TextStyle errorTextStyle;

  /// Text style for menu items in their default state.
  final TextStyle itemTextStyleNormal;

  /// Text style for menu items when hovered.
  final TextStyle itemTextStyleHover;

  /// Text style for the currently selected menu item.
  final TextStyle itemTextStyleSelected;

  // ==========================================================================
  // BORDER WIDTHS
  // ==========================================================================

  /// Border width for the dropdown button in normal state.
  final double borderWidth;

  /// Border width when the dropdown is open or focused.
  /// Usually thicker to indicate active state.
  final double borderWidthOpen;

  /// Border width for the focus ring.
  /// Used for the outer accessibility focus indicator.
  final double borderWidthFocused;

  // ==========================================================================
  // ANIMATION PROPERTIES
  // ==========================================================================

  /// Duration for all state transition animations.
  /// Affects hover, focus, open/close, and color transitions.
  final Duration animationDuration;

  /// Animation curve for all state transitions.
  /// Controls the easing of color and size animations.
  final Curve animationCurve;

  // ==========================================================================
  // OVERLAY PROPERTIES
  // ==========================================================================

  /// Material elevation for the dropdown menu overlay.
  /// Creates shadow depth to separate menu from background content.
  final double overlayElevation;

  /// Border radius for the dropdown menu overlay container.
  final double overlayBorderRadius;

  /// Border radius for individual menu items.
  /// Usually smaller than overlayBorderRadius for subtle inner rounding.
  final double itemBorderRadius;
}

// =============================================================================
// DROPDOWN ITEM INTERFACES
// =============================================================================

/// Universal interface for dropdown menu items.
///
/// Provides a standard contract for any object that can be displayed
/// in the dropdown menu, requiring both a display label and a unique value.
abstract class DropdownItem {
  /// The text to display in the dropdown menu and selected state.
  String get label;

  /// The unique identifier for this item, used for selection tracking.
  String get value;
}

/// Simple implementation of DropdownItem for basic use cases.
///
/// Suitable for most dropdown scenarios where you need a simple
/// text label and string value pairing.
class SimpleDropdownItem implements DropdownItem {
  const SimpleDropdownItem(this.label, this.value);

  @override
  final String label;

  @override
  final String value;
}

// =============================================================================
// MAIN DROPDOWN WIDGET
// =============================================================================

/// Universal dropdown widget with comprehensive config-based styling.
///
/// A production-grade dropdown component that supports:
/// - State-aware visual styling (hover, focus, selected, disabled)
/// - Keyboard navigation and accessibility
/// - Customizable validation and error display
/// - Smooth animations and transitions
/// - Type-safe item selection with generic support
///
/// The widget follows clean architecture principles by separating
/// all visual styling into a dedicated config class.
class AppDrownDownWidget<T extends DropdownItem> extends HookWidget {
  const AppDrownDownWidget({
    required this.items,
    required this.onChanged,
    required this.config,
    super.key,
    this.selectedValue,
    this.label,
    this.hint = 'Select option...',
    this.width,
    this.height = 48,
    this.enabled = true,
    this.showClearButton = false,
    this.leadingIcon,
    this.errorText,
    this.isRequired = false,
    this.maxMenuHeight = 200,
    this.showFocusRing = true,
    this.autofocus = false,
  });

  /// List of items to display in the dropdown menu.
  /// Each item must implement the DropdownItem interface.
  final List<T> items;

  /// Callback function called when a new item is selected.
  /// Receives the selected item or null if cleared.
  final ValueChanged<T?> onChanged;

  /// Configuration object containing all visual styling and layout properties.
  /// Allows for complete customization of the dropdown appearance.
  final AppDropdownWidgetConfig config;

  /// The currently selected value that determines which item appears selected.
  /// Should match the 'value' property of one of the items in the list.
  final String? selectedValue;

  /// Optional text label displayed above the dropdown.
  /// Useful for form fields and accessibility.
  final String? label;

  /// Placeholder text shown when no item is selected.
  /// Provides user guidance on the dropdown's purpose.
  final String hint;

  /// Optional fixed width for the dropdown button.
  /// If null, the dropdown will expand to fill available space.
  final double? width;

  /// Fixed height for the dropdown button.
  /// Controls the vertical size of the clickable area.
  final double height;

  /// Whether the dropdown is interactive.
  /// When false, the dropdown cannot be opened or interacted with.
  final bool enabled;

  /// Whether to show a clear button (X) when an item is selected.
  /// Allows users to reset the selection to null.
  final bool showClearButton;

  /// Optional icon displayed at the start of the dropdown button.
  /// Useful for categorizing or providing visual context.
  final Widget? leadingIcon;

  /// Error message text displayed below the dropdown in red.
  /// Used for validation feedback and form error states.
  final String? errorText;

  /// Whether this field is required.
  /// When true, displays an asterisk (*) next to the label.
  final bool isRequired;

  /// Maximum height for the dropdown menu overlay.
  /// When exceeded, the menu becomes scrollable.
  final double maxMenuHeight;

  /// Whether to show a focus ring around the dropdown when focused.
  /// Important for accessibility and keyboard navigation.
  final bool showFocusRing;

  /// Whether this dropdown should automatically receive focus when created.
  /// Useful for forms and user experience flows.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final isOpen = useState(false);
    final isFocused = useState(false);
    final overlayEntry = useState<OverlayEntry?>(null);
    final buttonKey = useState(GlobalKey());

    // Find selected item
    final selectedItem = items.where((item) => item.value == selectedValue).firstOrNull;

    void closeDropdown() {
      isOpen.value = false;
      overlayEntry.value?.remove();
      overlayEntry.value = null;
    }

    void openDropdown() {
      if (!enabled || items.isEmpty) return;

      final renderBox = buttonKey.value.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final offset = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      overlayEntry.value = OverlayEntry(
        builder: (context) => _DropdownOverlay(
          items: items,
          selectedValue: selectedValue,
          onItemSelected: (item) {
            onChanged(item as T?);
            closeDropdown();
          },
          onClose: closeDropdown,
          buttonOffset: offset,
          buttonSize: size,
          maxHeight: maxMenuHeight,
          config: config,
        ),
      );

      Overlay.of(context).insert(overlayEntry.value!);
      isOpen.value = true;
    }

    useEffect(
      () {
        return closeDropdown; // Cleanup on dispose
      },
      [],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: config.labelTextStyle,
              children: [
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: config.requiredTextColor),
                  ),
              ],
            ),
          ),
          SizedBox(height: config.labelSpacing),
        ],
        Focus(
          focusNode: focusNode,
          onFocusChange: (focused) => isFocused.value = focused,
          autofocus: autofocus,
          child: SizedBox(
            width: width,
            height: height,
            child: _DropdownButton(
              key: buttonKey.value,
              selectedItem: selectedItem,
              hint: hint,
              isOpen: isOpen.value,
              isFocused: isFocused.value,
              enabled: enabled,
              onTap: isOpen.value ? closeDropdown : openDropdown,
              leadingIcon: leadingIcon,
              showClearButton: showClearButton && selectedItem != null,
              onClear: () => onChanged(null),
              config: config,
              showFocusRing: showFocusRing,
            ),
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: config.errorSpacing),
          Text(
            errorText!,
            style: config.errorTextStyle,
          ),
        ],
      ],
    );
  }
}

// =============================================================================
// DROPDOWN BUTTON WIDGET
// =============================================================================

/// Internal dropdown button widget with comprehensive state-aware styling.
///
/// Handles all visual states (normal, hover, open, disabled, focused) and
/// provides smooth animated transitions between states using the config.
class _DropdownButton extends HookWidget {
  const _DropdownButton({
    required this.selectedItem,
    required this.hint,
    required this.isOpen,
    required this.isFocused,
    required this.enabled,
    required this.onTap,
    required this.showClearButton,
    required this.onClear,
    required this.config,
    required this.showFocusRing,
    super.key,
    this.leadingIcon,
  });

  final DropdownItem? selectedItem;
  final String hint;
  final bool isOpen;
  final bool isFocused;
  final bool enabled;
  final VoidCallback onTap;
  final Widget? leadingIcon;
  final bool showClearButton;
  final VoidCallback onClear;
  final AppDropdownWidgetConfig config;
  final bool showFocusRing;

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: config.animationDuration,
          curve: config.animationCurve,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(config.borderRadius),
            border: isFocused && showFocusRing
                ? Border.all(
                    color: config.focusRingColor,
                    width: config.borderWidthFocused,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )
                : null,
          ),
          child: AnimatedContainer(
            duration: config.animationDuration,
            curve: config.animationCurve,
            decoration: BoxDecoration(
              border: Border.all(
                color: _getBorderColor(isHovered.value, isOpen, isFocused),
                width: _getBorderWidth(isOpen, isFocused),
              ),
              borderRadius: BorderRadius.circular(config.borderRadius),
              color: _getBackgroundColor(isHovered.value, isOpen),
            ),
            padding: config.padding,
            child: Row(
              children: [
                if (leadingIcon != null) ...[
                  AnimatedContainer(
                    duration: config.animationDuration,
                    curve: config.animationCurve,
                    child: IconTheme(
                      data: IconThemeData(
                        color: _getIconColor(isHovered.value, isOpen),
                        size: config.iconSize,
                      ),
                      child: leadingIcon!,
                    ),
                  ),
                  SizedBox(width: config.spacing),
                ],
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: config.animationDuration,
                    curve: config.animationCurve,
                    style: _getTextStyle(isHovered.value, isOpen),
                    child: Text(
                      selectedItem?.label ?? hint,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (showClearButton) ...[
                  GestureDetector(
                    onTap: onClear,
                    child: AnimatedContainer(
                      duration: config.animationDuration,
                      curve: config.animationCurve,
                      child: Icon(
                        Icons.clear,
                        size: config.clearIconSize,
                        color: _getIconColor(isHovered.value, isOpen),
                      ),
                    ),
                  ),
                  SizedBox(width: config.spacing),
                ],
                AnimatedRotation(
                  duration: config.animationDuration,
                  curve: config.animationCurve,
                  turns: isOpen ? 0.5 : 0,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: _getIconColor(isHovered.value, isOpen),
                    size: config.iconSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(bool hovering, bool isOpen) {
    if (!enabled) {
      return config.disabledBackgroundColor;
    }
    if (isOpen) {
      return config.openBackgroundColor;
    }
    if (hovering) {
      return config.hoverBackgroundColor;
    }
    return config.backgroundColor;
  }

  Color _getBorderColor(bool hovering, bool isOpen, bool focused) {
    if (!enabled) {
      return config.disabledBorderColor;
    }
    if (isOpen) {
      return config.openBorderColor;
    }
    if (focused) {
      return config.focusedBorderColor;
    }
    if (hovering) {
      return config.hoverBorderColor;
    }
    return config.borderColor;
  }

  double _getBorderWidth(bool isOpen, bool focused) {
    if (isOpen || focused) {
      return config.borderWidthOpen;
    }
    return config.borderWidth;
  }

  Color _getIconColor(bool hovering, bool isOpen) {
    if (!enabled) {
      return config.disabledIconColor;
    }
    if (isOpen) {
      return config.openIconColor;
    }
    if (hovering) {
      return config.hoverIconColor;
    }
    return config.iconColor;
  }

  TextStyle _getTextStyle(bool hovering, bool isOpen) {
    if (!enabled) {
      return config.textStyleDisabled;
    }
    if (isOpen) {
      return config.textStyleOpen;
    }
    if (hovering) {
      return config.textStyleHover;
    }
    if (selectedItem != null) {
      return config.textStyleNormal;
    }
    return config.hintTextStyle;
  }
}

// =============================================================================
// DROPDOWN OVERLAY WIDGET
// =============================================================================

/// Overlay menu that appears when the dropdown is opened.
///
/// Positions itself below the dropdown button and provides a scrollable
/// list of menu items with proper Material Design elevation and styling.
class _DropdownOverlay extends HookWidget {
  const _DropdownOverlay({
    required this.items,
    required this.selectedValue,
    required this.onItemSelected,
    required this.onClose,
    required this.buttonOffset,
    required this.buttonSize,
    required this.maxHeight,
    required this.config,
  });

  final List<DropdownItem> items;
  final String? selectedValue;
  final ValueChanged<DropdownItem> onItemSelected;
  final VoidCallback onClose;
  final Offset buttonOffset;
  final Size buttonSize;
  final double maxHeight;
  final AppDropdownWidgetConfig config;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: ColoredBox(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: buttonOffset.dx,
              top: buttonOffset.dy + buttonSize.height + config.overlaySpacing,
              width: buttonSize.width,
              child: Material(
                elevation: config.overlayElevation,
                borderRadius: BorderRadius.circular(config.overlayBorderRadius),
                color: config.overlayBackgroundColor,
                shadowColor: config.overlayShadowColor,
                child: AnimatedContainer(
                  duration: config.animationDuration,
                  curve: config.animationCurve,
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(config.overlayBorderRadius),
                    border: Border.all(color: config.overlayBorderColor),
                  ),
                  child: ListView.builder(
                    padding: config.overlayPadding,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = item.value == selectedValue;

                      return _DropdownMenuItem(
                        item: item,
                        isSelected: isSelected,
                        onTap: () => onItemSelected(item),
                        config: config,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// DROPDOWN MENU ITEM WIDGET
// =============================================================================

/// Individual menu item within the dropdown overlay.
///
/// Supports hover states, selection indication, and smooth transitions.
/// Displays a checkmark icon when the item is currently selected.
class _DropdownMenuItem extends HookWidget {
  const _DropdownMenuItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.config,
  });

  final DropdownItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final AppDropdownWidgetConfig config;

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: config.animationDuration,
          curve: config.animationCurve,
          padding: config.itemPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(config.itemBorderRadius),
            color: _getBackgroundColor(isHovered.value, isSelected),
          ),
          child: Row(
            children: [
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: config.animationDuration,
                  curve: config.animationCurve,
                  style: _getTextStyle(isHovered.value, isSelected),
                  child: Text(
                    item.label,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (isSelected)
                AnimatedContainer(
                  duration: config.animationDuration,
                  curve: config.animationCurve,
                  child: Icon(
                    Icons.check,
                    size: config.clearIconSize,
                    color: _getIconColor(isHovered.value, isSelected),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(bool hovering, bool selected) {
    if (selected) {
      return config.itemSelectedBackgroundColor;
    }
    if (hovering) {
      return config.itemHoverBackgroundColor;
    }
    return config.itemBackgroundColor;
  }

  Color _getIconColor(bool hovering, bool selected) {
    if (selected) {
      return config.itemSelectedIconColor;
    }
    if (hovering) {
      return config.itemHoverIconColor;
    }
    return config.itemIconColor;
  }

  TextStyle _getTextStyle(bool hovering, bool selected) {
    if (selected) {
      return config.itemTextStyleSelected;
    }
    if (hovering) {
      return config.itemTextStyleHover;
    }
    return config.itemTextStyleNormal;
  }
}
