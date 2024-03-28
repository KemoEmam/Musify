import 'package:flutter/material.dart';
import 'package:musicfy/features/settings/presentation/views/widgets/dark_mode_button.dart';
import 'package:musicfy/features/settings/presentation/views/widgets/settings_appbar_widget.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SettingsAppBar(),
        SizedBox(height: 15),
        DarkModeButton(),
      ],
    );
  }
}
