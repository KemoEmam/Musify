import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/features/home/data/models/song_details_model.dart';
import 'package:musicfy/features/song/presentation/manager/pause_resume_cubit/pause_resume_cubit.dart';
import 'package:musicfy/features/song/presentation/views/widgets/neu_box_widget.dart';

class PlaybackActionsWidget extends StatelessWidget {
  const PlaybackActionsWidget({super.key, required this.songDetails});

  final SongDetailsModel songDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        NeuBoxWidget(
          onTap: () async {
            context.read<PauseResumeCubit>().previousSong(songDetails);
          },
          child: const Icon(Icons.skip_previous, size: 30),
        ),
        BlocBuilder<PauseResumeCubit, PauseResumeState>(
          builder: (context, state) {
            if (state is PauseResumePlaying) {
              return GestureDetector(
                onTap: () {
                  context.read<PauseResumeCubit>().togglePlayPause(songDetails);
                },
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const NeuBoxWidget(
                    child: Icon(Icons.pause, size: 30),
                  ),
                ),
              );
            } else if (state is PauseResumePaused) {
              return GestureDetector(
                onTap: () {
                  context.read<PauseResumeCubit>().togglePlayPause(songDetails);
                },
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const NeuBoxWidget(
                    child: Icon(Icons.play_arrow, size: 30),
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  context.read<PauseResumeCubit>().togglePlayPause(songDetails);
                },
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const NeuBoxWidget(
                    child: Icon(Icons.pause, size: 30),
                  ),
                ),
              );
            }
          },
        ),
        NeuBoxWidget(
          onTap: () async {
            context.read<PauseResumeCubit>().nextSong(songDetails);
          },
          child: const Icon(Icons.skip_next, size: 30),
        )
      ]),
    );
  }
}
