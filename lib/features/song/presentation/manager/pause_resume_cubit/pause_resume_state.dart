part of 'pause_resume_cubit.dart';

@immutable
sealed class PauseResumeState {}

final class PauseResumeInitial extends PauseResumeState {}

final class PauseResumePaused extends PauseResumeState {}

final class PauseResumePlaying extends PauseResumeState {}
