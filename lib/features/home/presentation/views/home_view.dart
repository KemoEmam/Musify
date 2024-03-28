import 'package:flutter/material.dart';
import 'package:musicfy/features/home/presentation/views/widgets/drawer_view_body.dart';
import 'package:musicfy/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const DrawerViewBody(),
      ),
      body: const HomeViewBody(),
    );
  }
}
