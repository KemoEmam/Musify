import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/features/settings/presentation/manager/dark_light_cubit/dark_light_cubit.dart';

class NeuBoxWidget extends StatelessWidget {
  const NeuBoxWidget({super.key, this.child, this.onTap});
  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        BlocProvider.of<DarkLightCubit>(context).state is DarkThemeState;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                spreadRadius: 5,
                color: isDarkMode ? Colors.black : Colors.grey.shade500,
                blurRadius: 15,
                offset: const Offset(4, 4),
              ),
              BoxShadow(
                color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                blurRadius: 15,
                offset: const Offset(-4, -4),
              )
            ]),
        child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
              bottom: 12,
            ),
            child: child),
      ),
    );
  }
}
