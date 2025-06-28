
import 'package:debug_app_web/features/home/presentation/views/setting/apperence_section.dart';
import 'package:debug_app_web/features/apperence/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/apperence/cubit/apperence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Font Section - Single Responsibility: Font family selection
class FontSection extends StatelessWidget {
  const FontSection({super.key});

  static const List<String> fontOptions = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Poppins',
    'Inter',
    'Source Sans Pro',
    'Ubuntu',
  ];

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Font',
      child: BlocBuilder<AppearanceCubit, AppearanceState>(
        buildWhen: (previous, current) => previous.fontFamily != current.fontFamily,
        builder: (context, state) {
          return DropdownButtonFormField<String>(
            value: fontOptions.contains(state.fontFamily)
                ? state.fontFamily
                : fontOptions.first,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: fontOptions.map((font) {
              return DropdownMenuItem(
                value: font,
                child: Text(font, style: TextStyle(fontFamily: font)),
              );
            }).toList(),
            onChanged: (font) {
              if (font != null) context.read<AppearanceCubit>().setFontFamily(font);
            },
          );
        },
      ),
    );
  }
}
