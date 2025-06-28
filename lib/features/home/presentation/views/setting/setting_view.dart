import 'package:debug_app_web/features/theme_system.dart/cubit/appearance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.read<AppearanceCubit>().currentThemeData.backgroundColorScheme.primary,
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            
          },
          child: const Text('Reset Theme'),
        ),
      ),
    );
  }
}
