import 'package:flutter/material.dart';

class CustomPopup extends StatefulWidget {
  const CustomPopup({
    required this.trigger,
    required this.popupContent,
    super.key,
    this.verticalOffset = 8.0,
    this.horizontalOffset = 0.0,
    this.maxHeight = 800,
    this.maxWidth = 400,
    this.backgroundColor, // <-- Added backgroundColor option
  });

  final Widget trigger;
  final Widget popupContent;
  final double verticalOffset;
  final double horizontalOffset;
  final double maxHeight;
  final double maxWidth;
  final Color? backgroundColor; // <-- Added backgroundColor field

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showPopup() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _hidePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    // Calculate available space
    final spaceBelow = screenSize.height -
        padding.bottom -
        (offset.dy + size.height + widget.verticalOffset);
    final spaceAbove = offset.dy - padding.top - widget.verticalOffset;
    

    // Determine vertical position
    bool showAbove;
    double availableHeight;
    if (spaceBelow >= widget.maxHeight || spaceBelow >= spaceAbove) {
      showAbove = false;
      availableHeight = spaceBelow;
    } else {
      showAbove = true;
      availableHeight = spaceAbove;
    }

    // Clamp height to available space
    final popupHeight = availableHeight.clamp(50.0, widget.maxHeight);

    // Calculate vertical offset
    final verticalOffset = showAbove
        ? -(popupHeight + widget.verticalOffset)
        : (size.height + widget.verticalOffset);

    // Calculate horizontal offset to keep popup on screen
    var horizontalOffset = widget.horizontalOffset;

    // Check if popup would go off the right edge
    if (offset.dx + horizontalOffset + widget.maxWidth >
        screenSize.width - padding.right) {
      // Position it to the left of the trigger or align to screen edge
      horizontalOffset =
          (screenSize.width - padding.right - offset.dx - widget.maxWidth).clamp(
        -offset.dx + padding.left, // Don't go past left edge
        widget.horizontalOffset,
      );
    }

    // Check if popup would go off the left edge
    if (offset.dx + horizontalOffset < padding.left) {
      horizontalOffset = padding.left - offset.dx;
    }

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _hidePopup,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(horizontalOffset, verticalOffset),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(4),
                color: widget.backgroundColor, // <-- Use backgroundColor if provided
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: popupHeight,
                    maxWidth: widget.maxWidth.clamp(
                      100.0,
                      screenSize.width - padding.horizontal - 16,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: widget.popupContent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hidePopup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (_overlayEntry == null) {
            _showPopup();
          } else {
            _hidePopup();
          }
        },
        child: widget.trigger,
      ),
    );
  }
}
