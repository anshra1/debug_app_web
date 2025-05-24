import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    required this.errorMessage,
    required this.fileLocation,
    required this.method,
    required this.networkError,
    required this.timestamp,
    required this.darkMode,
    super.key,
  });
  final String errorMessage;
  final String fileLocation;
  final String method;
  final String networkError;
  final String timestamp;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: darkMode ? Colors.grey[700]! : Colors.grey[300]!, // Border color
             // width: 2, // Increased border width for a thicker appearance
            ),
            boxShadow: [
              BoxShadow(
                color: darkMode
                    ? const Color(0xFF000000).withAlpha(18)
                    : Colors.grey.withAlpha((0.2 * 255).round()),
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: ColoredBox(
                color: darkMode
                    ? Colors.grey[900]!.withAlpha((0.7 * 255).round())
                    : Colors.white.withAlpha((0.8 * 255).round()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    ErrorCardHeader(darkMode: darkMode),
                    // Body
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Error Message
                          Text(
                            errorMessage,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: Colors.black38, thickness: .5),
                          const SizedBox(height: 16),
                          // Key-Value Pairs
                          ErrorDetailItem(
                            keyValue: 'FILE LOCATION:',
                            value: fileLocation,
                            colorScheme: colorScheme,
                            textTheme: textTheme,
                            darkMode: darkMode,
                          ),
                          ErrorDetailItem(
                            keyValue: 'METHOD:',
                            value: method,
                            colorScheme: colorScheme,
                            textTheme: textTheme,
                            darkMode: darkMode,
                          ),
                          ErrorDetailItem(
                            keyValue: 'NETWORK:',
                            value: networkError,
                            colorScheme: colorScheme,
                            textTheme: textTheme,
                            darkMode: darkMode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorCardHeader extends StatelessWidget {
  const ErrorCardHeader({required this.darkMode, super.key});
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red[100]!,
            Colors.red[50]!,
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: darkMode ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Socket Exception',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ErrorDetailItem extends StatelessWidget {
  const ErrorDetailItem({
    required this.keyValue,
    required this.value,
    required this.colorScheme,
    required this.textTheme,
    required this.darkMode,
    super.key,
  });

  final String keyValue;
  final String value;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              keyValue,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: darkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Tooltip(
              message: value,
              child: Text(
                value,
                style: textTheme.bodyMedium?.copyWith(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: darkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
