part of 'topscores_cubit.dart';

@immutable
abstract class TopscoresState {}

class TopscoresInitial extends TopscoresState {}

class TopscoresSuccess extends TopscoresState {
  final TopScores ourResponse;
  TopscoresSuccess({required this.ourResponse});
}

class TopscoresError extends TopscoresState {}
