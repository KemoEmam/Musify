import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/features/song/presentation/manager/song_slider_cubit/song_slider_cubit.dart';

class SongSlideBarWidget extends StatelessWidget {
  const SongSlideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongSliderCubit, SongSliderState>(
      builder: (context, state) {
        if (state is SongSliderSuccess) {
          final durationInSeconds = state.totalDuration.inSeconds.toDouble();
          final positionInSeconds = state.currentDuration.inSeconds.toDouble();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Opacity(
              opacity: .5,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0,
                  ),
                ),
                child: Slider(
                  activeColor: Colors.teal,
                  min: 0,
                  max: durationInSeconds.toDouble(),
                  value:
                      positionInSeconds.clamp(0, durationInSeconds.toDouble()),
                  onChanged: (double value) {
                    BlocProvider.of<SongSliderCubit>(context).seek(value);
                  },
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
