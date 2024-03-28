import 'package:flutter/material.dart';
import 'package:musicfy/core/utils/styles.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 25),
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'P L A Y L I S T',
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
    );
  }
}
