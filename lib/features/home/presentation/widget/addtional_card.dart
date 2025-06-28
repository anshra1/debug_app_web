
import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditionalDetailsErrorCard extends StatelessWidget {
  const AdditionalDetailsErrorCard({
    required this.additionalInfo,
    super.key,
  });

  final Map<String, String>? additionalInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // If we have additional information, show here in key and value pair
        ...?additionalInfo?.entries.map(
          (entry) => CardTextRow(
            leftText: '${entry.key.isNotEmpty ? entry.key[0].toUpperCase() + entry.key.substring(1) : entry.key} :',
            rightText: entry.value,
          ),
        ),
      ],
    );
  }
}

class CardTextRow extends StatelessWidget {
  const CardTextRow({
    required this.leftText,
    required this.rightText,
    this.leftTextColor = UIConfig.errorCardTextColor,
    this.rightTextColor = UIConfig.errorCardTextColor,
    this.leftTextSize = 16,
    this.rightTextSize = 18,
    super.key,
    this.rightTextStartAt = 120, // default fixed start
  });
  final String leftText;
  final String rightText;
  final double leftTextSize;
  final double rightTextSize;
  final Color leftTextColor;
  final Color rightTextColor;
  final double rightTextStartAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: rightTextStartAt,
            child: Text(
              leftText,
              style: GoogleFonts.inter(
                fontSize: leftTextSize,
                color: leftTextColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
          Flexible(
            child: Text(
              rightText,
              style: GoogleFonts.inter(
                fontSize: rightTextSize,
                color: rightTextColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
