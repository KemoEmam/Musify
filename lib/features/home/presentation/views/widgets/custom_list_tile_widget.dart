import 'package:flutter/material.dart';
import 'package:musicfy/core/utils/styles.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget(
      {super.key, required this.text, required this.icon, this.onTap});
  final IconData icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
        ),
        title: Text(
          text,
          style: Styles.textStyle16,
        ),
      ),
    );
  }
}
