import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:debug_app_web/core/utils/utils/stack_trace_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class StackTraceCard extends HookWidget {
  const StackTraceCard({required this.stackTrace, super.key});
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        //  color: Colors.blueAccent.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: UIConfig.borderColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StackTraceHeader(),
            const Gap(8),
            const Divider(
              color: UIConfig.borderColor,
              thickness: .8,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 600,
                minHeight: 300,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16).copyWith(top: 8, bottom: 8),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      isExpanded.value
                          ? stackTrace.toString() // Full, readable stack trace
                          : getShortStackTrace(stackTrace),
                      style: const TextStyle(
                        fontSize: UIConfig.stackTraceCardFontSize,
                        color: UIConfig.stackTraceCardTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  isExpanded.value = !isExpanded.value; // Update the state locally
                },
                child: Text(
                  isExpanded.value ? 'Show Less' : 'Show More',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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

class StackTraceHeader extends StatelessWidget {
  const StackTraceHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.layers,
          size: 28,
          color: Colors.white,
        ),
        const SizedBox(width: 16),
        Text(
          'StackTrace',
          style: GoogleFonts.inter(
            fontSize: 24,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Replace textColor with a defined color
          ),
        ),
      ],
    );
  }
}
