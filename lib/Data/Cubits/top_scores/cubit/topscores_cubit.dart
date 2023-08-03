import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../Models/tab_bars/top_scores/top_scores/top_scores.dart';
import '../../../Repositories/top_repo.dart';

part 'topscores_state.dart';

class TopscoresCubit extends Cubit<TopscoresState> {
  TopscoresCubit() : super(TopscoresInitial());

  getTop(leagueId) {
    TopScorersRepo().getTopScorers(leagueId).then((value) {
      if (value != null) {
        emit(TopscoresSuccess(ourResponse: value));
      } else {
        emit(TopscoresError());
      }
    });
  }
}
