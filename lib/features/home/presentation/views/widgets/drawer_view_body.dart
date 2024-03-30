import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicfy/core/utils/app_routes.dart';
import 'package:musicfy/core/utils/assets.dart';
import 'package:musicfy/core/utils/styles.dart';
import 'package:musicfy/features/home/presentation/views/widgets/custom_list_tile_widget.dart';

class DrawerViewBody extends StatelessWidget {
  const DrawerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: Image.asset(AssetsData.logo),
          ),
          const SizedBox(height: 105),
          CustomListTileWidget(
            text: 'H O M E',
            icon: Icons.home,
            onTap: () => GoRouter.of(context).pop(),
          ),
          const SizedBox(height: 30),
          CustomListTileWidget(
            text: 'S E T T I N G S',
            icon: Icons.settings,
            onTap: () {
              GoRouter.of(context).pop();
              GoRouter.of(context).push(AppRoutes.settingsRoute);
            },
          ),
          const Spacer(),
          Opacity(
            opacity: 0.3,
            child: Text(
              'Copyright ©2024 Karim El-Emam, Inc.',
              style: Styles.textStyle14.copyWith(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Opacity(
              opacity: 0.3,
              child: Text('All rights reserved, Musify™',
                  style:
                      Styles.textStyle14.copyWith(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
