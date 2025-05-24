import 'package:flutter/material.dart';

class ImprovedErrorCard extends StatelessWidget {
  final String errorTitle;
  final String errorMessage;
  final String fileLocation;
  final String method;
  final String networkError;
  final String timestamp;
  final VoidCallback? onRetry;

  const ImprovedErrorCard({
    Key? key,
    required this.errorTitle,
    required this.errorMessage,
    required this.fileLocation,
    required this.method,
    required this.networkError,
    required this.timestamp,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pastelRed = const Color(0xFFFFCDD2);
    final darkRed = const Color(0xFFB71C1C);
    final darkPink = const Color(0xFF880E4F);

    return Semantics(
      label: 'Error card: $errorTitle',
      container: true,
      child: Container(
       // width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: pastelRed,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        //constraints: BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with icon, title, timestamp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: darkRed, size: 26),
                    const SizedBox(width: 8),
                    Text(
                      errorTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: darkRed,
                      ),
                    ),
                  ],
                ),
                Text(
                  timestamp,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: darkPink,
                  ),
                )
              ],
            ),

            const SizedBox(height: 8),

            // Error message
            Text(
              errorMessage,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: darkRed,
              ),
            ),

            const SizedBox(height: 12),

            // File location and path on one line
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'File: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: darkRed,
                  ),
                ),
                Expanded(
                  child: Text(
                    fileLocation,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: darkRed,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Method on one line
            Row(
              children: [
                Text(
                  'Method: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: darkRed,
                  ),
                ),
                Expanded(
                  child: Text(
                    method,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: darkRed,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Network error on one line
            Row(
              children: [
                Text(
                  'Network: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: darkRed,
                  ),
                ),
                Expanded(
                  child: Text(
                    networkError,
                    style: TextStyle(
                      fontSize: 13,
                      color: darkRed,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Retry button
            if (onRetry != null)
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkRed,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
