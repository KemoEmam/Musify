import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfy/core/utils/styles.dart';
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
          final isRepeatOn = (state).isRepeatOn;
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    formatTime(Duration(seconds: positionInSeconds.toInt())),
                    style: Styles.textStyle14,
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<SongSliderCubit>(context).toggleRepeat();
                    },
                    icon: Icon(
                      Icons.repeat,
                      color: isRepeatOn ? Colors.teal : Colors.black,
                    ),
                  ),
                  Text(
                    formatTime(Duration(seconds: durationInSeconds.toInt())),
                  )
                ],
              ),
              Padding(
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
                      value: positionInSeconds.clamp(
                          0, durationInSeconds.toDouble()),
                      onChanged: (double value) {
                        BlocProvider.of<SongSliderCubit>(context).seek(value);
                      },
                    ),
                  ),
                ),
              )
            ]),
          );
        }
        return const SizedBox();
      },
    );
  }

  String formatTime(Duration duration) {
    String twoDigitsSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitsSeconds";
    return formattedTime;
  }
}
