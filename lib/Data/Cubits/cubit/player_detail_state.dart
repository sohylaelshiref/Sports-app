part of 'player_detail_cubit.dart';

@immutable
abstract class PlayerDetailState {}

class PlayerDetailLoading extends PlayerDetailState {}

class PlayerDetailSuccess extends PlayerDetailState {
  final Players ourResponse;
  PlayerDetailSuccess({required this.ourResponse});
}

class PlayerDetailError extends PlayerDetailState {}
