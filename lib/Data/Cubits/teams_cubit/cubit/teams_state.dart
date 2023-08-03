part of 'teams_cubit.dart';

@immutable
abstract class TeamsState {}

class TeamsLoading extends TeamsState {}

class TeamsSuccess extends TeamsState {
  final Teams ourResponse;
  TeamsSuccess({required this.ourResponse});
}

class TeamsError extends TeamsState {}
