import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicfy/core/utils/styles.dart';

class FavouritesAppBar extends StatelessWidget {
  const FavouritesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 15),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'F A V O U R I T E S',
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
    );
  }
}
