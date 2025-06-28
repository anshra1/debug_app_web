import 'package:debug_app_web/features/home/presentation/views/setting/apperence_section.dart';
import 'package:debug_app_web/features/home/presentation/views/setting/header.dart';
import 'package:debug_app_web/features/apperence/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/apperence/cubit/apperence_state.dart';
import 'package:debug_app_web/features/apperence/widget/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutSection extends StatelessWidget {
  const LayoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Layout & Text Direction',
      child: Column(
        children: [
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.layoutDirection != current.layoutDirection,
            builder: (context, state) {
              return RadioGroup<LayoutDirection>(
                title: 'Layout Direction',
                value: state.layoutDirection,
                options: const [
                  RadioOption(LayoutDirection.ltr, 'Left to Right'),
                  RadioOption(LayoutDirection.rtl, 'Right to Left'),
                ],
                onChanged: (direction) =>
                    context.read<AppearanceCubit>().setLayoutDirection(direction),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.textDirection != current.textDirection,
            builder: (context, state) {
              return RadioGroup<TextDirection>(
                title: 'Text Direction',
                value: state.textDirection,
                options: const [
                  RadioOption(TextDirection.ltr, 'Left to Right'),
                  RadioOption(TextDirection.rtl, 'Right to Left'),
                ],
                onChanged: (direction) =>
                    context.read<AppearanceCubit>().setTextDirection(direction),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.enableRtlToolbarItems != current.enableRtlToolbarItems,
            builder: (context, state) {
              return SwitchListTile(
                title: const Text('Enable RTL Toolbar Items'),
                subtitle: const Text('Show right-to-left toolbar items'),
                value: state.enableRtlToolbarItems,
                onChanged: (value) =>
                    context.read<AppearanceCubit>().setEnableRTLToolbarItems(value),
                contentPadding: EdgeInsets.zero,
              );
            },
          ),
        ],
      ),
    );
  }
}
