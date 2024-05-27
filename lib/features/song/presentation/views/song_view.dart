import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicfy/features/song/presentation/views/widgets/song_view_body.dart';
import '../../../home/data/models/song_details_model.dart';

class SongView extends StatelessWidget {
  const SongView({super.key});

  @override
  Widget build(BuildContext context) {
    final songDetails = GoRouterState.of(context).extra as SongDetailsModel;
    return Scaffold(
      body: SongViewBody(
        songDetails: songDetails,
      ),
    );
  }
}
