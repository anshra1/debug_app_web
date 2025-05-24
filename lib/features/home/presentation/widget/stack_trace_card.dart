import 'package:flutter/material.dart';

class StackTraceCard extends StatefulWidget {
  const StackTraceCard({required this.trace, super.key});
  final String trace;

  @override
  State<StackTraceCard> createState() => _StackTraceCardState();
}

class _StackTraceCardState extends State<StackTraceCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white70 : Colors.black87;
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;

    // Split the trace into lines
    final allLines = widget.trace.split('\n');
    final visibleLines = _isExpanded ? allLines : allLines.take(3).toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stack Trace (${allLines.length})',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: visibleLines.isEmpty ? 0 : 0, // Changed to 0 instead of null
              maxHeight: _isExpanded ? double.infinity : 100,
            ),
            child: SingleChildScrollView(
              physics: _isExpanded ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: visibleLines.map((line) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      line,
                      style: TextStyle(
                        fontFamily: 'Monospace',
                        fontSize: 18,
                        color: textColor.withOpacity(0.8),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Show Less' : 'Show More',
                  style: TextStyle(
                    color: Colors.blueAccent.shade400,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
