import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:debug_app_web/core/utils/utils/stack_trace_utils.dart';
import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';
import 'package:debug_app_web/features/home/presentation/widget/addtional_card.dart';
import 'package:debug_app_web/features/home/presentation/widget/stack_trace_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ErrorCardView extends HookWidget {
  const ErrorCardView({
    required this.currentErrorData,
    super.key,
  });

  final ValueNotifier<ErrorTracking?> currentErrorData;

  @override
  Widget build(BuildContext context) {
    final data = useValueListenable(currentErrorData);

    final errorLocation =
        data != null ? extractErrorLocation(data.currentError.stackTrace) : null;

    return Align(
      alignment: Alignment.topCenter,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: UIConfig.middlePanelPadding),
        shrinkWrap: true,
        //  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 25, 25, 26),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white12,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  const ErrorCardHeader(),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      data?.currentError.error ??
                          'Error: Unable to load data. Please try again later.',
                      softWrap: true,
                      style: GoogleFonts.roboto(
                        color: UIConfig.errorCardTextColor,
                        fontSize: UIConfig.errorCardFontSize,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Gap(8),
                  CardTextRow(
                    leftText: 'PATH :',
                    rightText: errorLocation ?? '',
                  ),
                  AdditionalDetailsErrorCard(
                    additionalInfo: data?.currentError.additionalInfo,
                  ),
                  const Gap(16),
                ],
              ),
            ),
          ),
          const Gap(24),
          
            StackTraceCard(
              stackTrace: StackTrace.fromString(data?.currentError.stackTrace ?? ''),
            ),
          const Gap(24),
        ],
      ),
    );
  }
}

class ErrorCardHeader extends StatelessWidget {
  const ErrorCardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: UIConfig.errorCardHeaderColor,
      child: const Row(
        children: [
          Spacer(),
          Icon(
            LucideIcons.copy,
            size: 24,
            color: UIConfig.errorCardIconColor,
          ),
          Gap(16),
        ],
      ),
    );
  }
}
