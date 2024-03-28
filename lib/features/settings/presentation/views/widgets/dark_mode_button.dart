import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/core/utils/styles.dart';
import 'package:musicfy/features/settings/presentation/manager/dark_light_cubit/dark_light_cubit.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<DarkLightCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark Mode',
              style: Styles.textStyle16,
            ),
            BlocBuilder<DarkLightCubit, DarkLightState>(
              builder: (context, state) {
                bool isDarkMode = state is DarkThemeState;
                return CupertinoSwitch(
                  value: isDarkMode,
                  onChanged: (value) {
                    themeCubit.toggleTheme();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
