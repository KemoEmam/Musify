import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicfy/core/utils/app_routes.dart';
import 'package:musicfy/core/utils/styles.dart';

class SongsAppBarWidget extends StatelessWidget {
  const SongsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 15),
      child: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'S O N G S',
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w400),
        ),
        actions: [
          PopupMenuButton(
            color: colorScheme.primary,
            onSelected: (String result) {
              switch (result) {
                case 'GoToFavourites':
                  GoRouter.of(context).push(AppRoutes.favouritesRoute);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'GoToFavourites',
                child: Text('Go to favourites'),
              ),
              // Add other PopupMenuItems for different options as needed
            ],
          ),
        ],
      ),
    );
  }
}
