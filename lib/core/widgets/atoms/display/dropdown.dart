// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:appflowy/shared/google_fonts_extension.dart';
// import 'package:appflowy/workspace/application/settings/appearance/appearance_cubit.dart';
// import 'package:appflowy/workspace/application/settings/appearance/base_appearance.dart';
// import 'package:appflowy/util/font_family_extension.dart';
// import 'package:flowy_infra_ui/flowy_infra_ui.dart';
// import 'package:google_fonts/google_fonts.dart';

// /// A reusable dropdown item model
// class AppFlowyDropdownItem<T> {
//   const AppFlowyDropdownItem({
//     required this.value,
//     required this.label,
//     this.displayName,
//     this.leadingIcon,
//     this.trailingIcon,
//     this.subtitle,
//     this.fontFamily,
//     this.isEnabled = true,
//   });

//   final T value;
//   final String label;
//   final String? displayName;
//   final Widget? leadingIcon;
//   final Widget? trailingIcon;
//   final String? subtitle;
//   final String? fontFamily;
//   final bool isEnabled;

//   String get effectiveDisplayName => displayName ?? label;
// }

// /// Reusable dropdown component class
// class AppFlowyDropdown<T> extends StatefulWidget {
//   const AppFlowyDropdown({
//     super.key,
//     required this.selectedValue,
//     required this.items,
//     this.onChanged,
//     this.onReset,
//     this.showResetButton = false,
//     this.showSearch = false,
//     this.placeholder = 'Select an option',
//     this.resetLabel = 'Reset',
//     this.emptyMessage = 'No options available',
//     this.width,
//     this.maxHeight = 300,
//     this.decoration,
//     this.textStyle,
//     this.dropdownIcon,
//     this.resetIcon,
//     this.searchHint = 'Search...',
//     this.isDisabled = false,
//     this.showFontPreview = false,
//   });

//   /// Currently selected value
//   final T? selectedValue;
  
//   /// List of dropdown items
//   final List<AppFlowyDropdownItem<T>> items;
  
//   /// Callback when selection changes
//   final void Function(T? value)? onChanged;
  
//   /// Callback when reset is pressed
//   final VoidCallback? onReset;
  
//   /// Whether to show reset button
//   final bool showResetButton;
  
//   /// Whether to show search functionality
//   final bool showSearch;
  
//   /// Placeholder text when no selection
//   final String placeholder;
  
//   /// Reset button label
//   final String resetLabel;
  
//   /// Message when no items found
//   final String emptyMessage;
  
//   /// Dropdown width
//   final double? width;
  
//   /// Maximum dropdown height
//   final double maxHeight;
  
//   /// Input decoration
//   final InputDecoration? decoration;
  
//   /// Text style
//   final TextStyle? textStyle;
  
//   /// Dropdown arrow icon
//   final Widget? dropdownIcon;
  
//   /// Reset button icon
//   final Widget? resetIcon;
  
//   /// Search hint text
//   final String searchHint;
  
//   /// Whether dropdown is disabled
//   final bool isDisabled;
  
//   /// Whether to show font preview (for font dropdowns)
//   final bool showFontPreview;

//   @override
//   State<AppFlowyDropdown<T>> createState() => _AppFlowyDropdownState<T>();
// }

// class _AppFlowyDropdownState<T> extends State<AppFlowyDropdown<T>> {
//   late final TextEditingController _textController;
//   late final FocusNode _focusNode;
//   late final PopoverController _popoverController;
//   late List<AppFlowyDropdownItem<T>> _filteredItems;
  
//   @override
//   void initState() {
//     super.initState();
//     _textController = TextEditingController();
//     _focusNode = FocusNode();
//     _popoverController = PopoverController();
//     _filteredItems = widget.items;
    
//     _updateDisplayText();
//   }
  
//   @override
//   void didUpdateWidget(AppFlowyDropdown<T> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selectedValue != widget.selectedValue) {
//       _updateDisplayText();
//     }
//     if (oldWidget.items != widget.items) {
//       _filteredItems = widget.items;
//     }
//   }
  
//   void _updateDisplayText() {
//     final selectedItem = widget.items.firstWhere(
//       (item) => item.value == widget.selectedValue,
//       orElse: () => AppFlowyDropdownItem<T>(
//         value: widget.selectedValue as T,
//         label: widget.placeholder,
//       ),
//     );
    
//     _textController.text = widget.selectedValue != null 
//         ? selectedItem.effectiveDisplayName
//         : widget.placeholder;
//   }
  
//   void _onSearchChanged(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _filteredItems = widget.items;
//       } else {
//         _filteredItems = widget.items.where((item) {
//           return item.label.toLowerCase().contains(query.toLowerCase()) ||
//                  item.effectiveDisplayName.toLowerCase().contains(query.toLowerCase());
//         }).toList();
//       }
//     });
//   }
  
//   void _onItemSelected(AppFlowyDropdownItem<T> item) {
//     if (!item.isEnabled) return;
    
//     widget.onChanged?.call(item.value);
//     _updateDisplayText();
//     _popoverController.close();
//     _focusNode.unfocus();
//   }
  
//   void _onResetPressed() {
//     widget.onReset?.call();
//     _popoverController.close();
//     _focusNode.unfocus();
//   }
  
//   @override
//   void dispose() {
//     _textController.dispose();
//     _focusNode.dispose();
//     _popoverController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.width,
//       child: Row(
//         children: [
//           Expanded(
//             child: AppFlowyPopover(
//               controller: _popoverController,
//               direction: PopoverDirection.bottomWithLeftAligned,
//               constraints: BoxConstraints(
//                 maxHeight: widget.maxHeight,
//                 maxWidth: widget.width ?? 300,
//                 minWidth: 200,
//               ),
//               popupBuilder: (_) => _DropdownPopup<T>(
//                 items: _filteredItems,
//                 selectedValue: widget.selectedValue,
//                 onItemSelected: _onItemSelected,
//                 onSearchChanged: widget.showSearch ? _onSearchChanged : null,
//                 searchHint: widget.searchHint,
//                 emptyMessage: widget.emptyMessage,
//                 showFontPreview: widget.showFontPreview,
//               ),
//               child: _DropdownInput(
//                 controller: _textController,
//                 focusNode: _focusNode,
//                 decoration: widget.decoration ?? _defaultDecoration(context),
//                 textStyle: widget.textStyle,
//                 dropdownIcon: widget.dropdownIcon,
//                 isDisabled: widget.isDisabled,
//                 onTap: () {
//                   if (!widget.isDisabled) {
//                     _focusNode.requestFocus();
//                     _popoverController.show();
//                   }
//                 },
//               ),
//             ),
//           ),
//           if (widget.showResetButton) ...[
//             const SizedBox(width: 12),
//             _ResetButton(
//               onPressed: widget.isDisabled ? null : _onResetPressed,
//               label: widget.resetLabel,
//               icon: widget.resetIcon,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
  
//   InputDecoration _defaultDecoration(BuildContext context) {
//     return InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(
//           color: Theme.of(context).colorScheme.outline,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(
//           color: Theme.of(context).colorScheme.primary,
//         ),
//       ),
//       contentPadding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 12,
//       ),
//     );
//   }
// }

// /// Dropdown input field component
// class _DropdownInput extends StatelessWidget {
//   const _DropdownInput({
//     required this.controller,
//     required this.focusNode,
//     required this.decoration,
//     required this.onTap,
//     this.textStyle,
//     this.dropdownIcon,
//     this.isDisabled = false,
//   });

//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final InputDecoration decoration;
//   final VoidCallback onTap;
//   final TextStyle? textStyle;
//   final Widget? dropdownIcon;
//   final bool isDisabled;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AbsorbPointer(
//         absorbing: true,
//         child: TextField(
//           controller: controller,
//           focusNode: focusNode,
//           enabled: !isDisabled,
//           style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
//           decoration: decoration.copyWith(
//             suffixIcon: dropdownIcon ?? 
//                 Icon(
//                   Icons.arrow_drop_down,
//                   color: isDisabled 
//                       ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
//                       : Theme.of(context).colorScheme.onSurface,
//                 ),
//           ),
//           readOnly: true,
//         ),
//       ),
//     );
//   }
// }

// /// Dropdown popup content
// class _DropdownPopup<T> extends StatefulWidget {
//   const _DropdownPopup({
//     required this.items,
//     required this.onItemSelected,
//     this.selectedValue,
//     this.onSearchChanged,
//     this.searchHint = 'Search...',
//     this.emptyMessage = 'No options available',
//     this.showFontPreview = false,
//   });

//   final List<AppFlowyDropdownItem<T>> items;
//   final T? selectedValue;
//   final void Function(AppFlowyDropdownItem<T>) onItemSelected;
//   final void Function(String)? onSearchChanged;
//   final String searchHint;
//   final String emptyMessage;
//   final bool showFontPreview;

//   @override
//   State<_DropdownPopup<T>> createState() => _DropdownPopupState<T>();
// }

// class _DropdownPopupState<T> extends State<_DropdownPopup<T>> {
//   late final TextEditingController _searchController;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 8,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Theme.of(context).cardColor,
//           border: Border.all(
//             color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (widget.onSearchChanged != null) ...[
//               _SearchField(
//                 controller: _searchController,
//                 onChanged: widget.onSearchChanged!,
//                 hint: widget.searchHint,
//               ),
//               const SizedBox(height: 8),
//             ],
//             if (widget.items.isEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   widget.emptyMessage,
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//                   ),
//                 ),
//               )
//             else
//               Flexible(
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   itemCount: widget.items.length,
//                   separatorBuilder: (_, __) => const SizedBox(height: 4),
//                   itemBuilder: (context, index) {
//                     final item = widget.items[index];
//                     final isSelected = item.value == widget.selectedValue;
                    
//                     return _DropdownItem<T>(
//                       item: item,
//                       isSelected: isSelected,
//                       onTap: () => widget.onItemSelected(item),
//                       showFontPreview: widget.showFontPreview,
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// Search field for dropdown
// class _SearchField extends StatelessWidget {
//   const _SearchField({
//     required this.controller,
//     required this.onChanged,
//     required this.hint,
//   });

//   final TextEditingController controller;
//   final void Function(String) onChanged;
//   final String hint;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         hintText: hint,
//         prefixIcon: const Icon(Icons.search, size: 20),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
//           ),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 8,
//         ),
//         isDense: true,
//       ),
//       style: Theme.of(context).textTheme.bodySmall,
//     );
//   }
// }

// /// Individual dropdown item
// class _DropdownItem<T> extends StatelessWidget {
//   const _DropdownItem({
//     required this.item,
//     required this.isSelected,
//     required this.onTap,
//     this.showFontPreview = false,
//   });

//   final AppFlowyDropdownItem<T> item;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final bool showFontPreview;

//   @override
//   Widget build(BuildContext context) {
//     final textStyle = showFontPreview && item.fontFamily != null
//         ? getGoogleFontSafely(item.fontFamily!).copyWith(
//             color: item.isEnabled 
//                 ? Theme.of(context).colorScheme.onSurface
//                 : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
//           )
//         : Theme.of(context).textTheme.bodyMedium?.copyWith(
//             color: item.isEnabled 
//                 ? Theme.of(context).colorScheme.onSurface
//                 : Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
//           );

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: item.isEnabled ? onTap : null,
//         borderRadius: BorderRadius.circular(6),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(6),
//             color: isSelected 
//                 ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
//                 : null,
//           ),
//           child: Row(
//             children: [
//               if (item.leadingIcon != null) ...[
//                 item.leadingIcon!,
//                 const SizedBox(width: 8),
//               ],
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       item.effectiveDisplayName,
//                       style: textStyle,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     if (item.subtitle != null) ...[
//                       const SizedBox(height: 2),
//                       Text(
//                         item.subtitle!,
//                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               if (item.trailingIcon != null) ...[
//                 const SizedBox(width: 8),
//                 item.trailingIcon!,
//               ],
//               if (isSelected) ...[
//                 const SizedBox(width: 8),
//                 Icon(
//                   Icons.check,
//                   size: 16,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Reset button component
// class _ResetButton extends StatelessWidget {
//   const _ResetButton({
//     required this.onPressed,
//     required this.label,
//     this.icon,
//   });

//   final VoidCallback? onPressed;
//   final String label;
//   final Widget? icon;

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton.icon(
//       onPressed: onPressed,
//       icon: icon ?? const Icon(Icons.refresh, size: 16),
//       label: Text(label),
//       style: OutlinedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         minimumSize: const Size(0, 36),
//       ),
//     );
//   }
// }

// // ==============================================================================
// // SPECIALIZED DROPDOWN CLASSES
// // ==============================================================================

// /// Font family dropdown
// class FontFamilyDropdown extends StatelessWidget {
//   const FontFamilyDropdown({
//     super.key,
//     required this.selectedFont,
//     this.onChanged,
//     this.showSystemFont = true,
//     this.width,
//   });

//   final String selectedFont;
//   final void Function(String?)? onChanged;
//   final bool showSystemFont;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     final fontItems = <AppFlowyDropdownItem<String>>[
//       if (showSystemFont)
//         AppFlowyDropdownItem<String>(
//           value: defaultFontFamily,
//           label: defaultFontFamily,
//           displayName: 'System Font',
//           leadingIcon: const Icon(Icons.computer, size: 16),
//         ),
//       ...GoogleFonts.asMap().keys.take(20).map((fontName) =>
//         AppFlowyDropdownItem<String>(
//           value: fontName,
//           label: fontName,
//           fontFamily: fontName,
//         ),
//       ),
//     ];

//     return AppFlowyDropdown<String>(
//       selectedValue: selectedFont,
//       items: fontItems,
//       onChanged: onChanged,
//       showResetButton: true,
//       showSearch: true,
//       showFontPreview: true,
//       placeholder: 'Select Font',
//       searchHint: 'Search fonts...',
//       width: width,
//       onReset: () => onChanged?.call(defaultFontFamily),
//     );
//   }
// }

// /// Theme dropdown
// class ThemeDropdown extends StatelessWidget {
//   const ThemeDropdown({
//     super.key,
//     required this.selectedTheme,
//     required this.availableThemes,
//     this.onChanged,
//     this.width,
//   });

//   final String selectedTheme;
//   final List<String> availableThemes;
//   final void Function(String?)? onChanged;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     final themeItems = availableThemes.map((theme) =>
//       AppFlowyDropdownItem<String>(
//         value: theme,
//         label: theme,
//         leadingIcon: Container(
//           width: 16,
//           height: 16,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: _getThemeColor(theme),
//             border: Border.all(
//               color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
//             ),
//           ),
//         ),
//       ),
//     ).toList();

//     return AppFlowyDropdown<String>(
//       selectedValue: selectedTheme,
//       items: themeItems,
//       onChanged: onChanged,
//       placeholder: 'Select Theme',
//       width: width,
//     );
//   }

//   Color _getThemeColor(String themeName) {
//     // This would normally come from your theme system
//     switch (themeName.toLowerCase()) {
//       case 'light': return Colors.white;
//       case 'dark': return Colors.black87;
//       case 'blue': return Colors.blue;
//       case 'green': return Colors.green;
//       default: return Colors.grey;
//     }
//   }
// }