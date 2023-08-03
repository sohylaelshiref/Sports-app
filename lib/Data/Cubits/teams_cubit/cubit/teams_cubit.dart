import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../Models/tab_bars/teams/teams/teams.dart';
import '../../../Repositories/teams_repo.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit() : super(TeamsLoading());
  getTeams(leagueId) {
    TeamsRepo().getAllTeams(leagueId).then((value) {
      if (value != null) {
        emit(TeamsSuccess(ourResponse: value));
      } else {
        emit(TeamsError());
      }
    });
  }

  Future<void> searchByTeamName(String searchText, int leagueId) async {
    emit(TeamsLoading());

    TeamsRepo().searchByTeam(searchText, leagueId).then((value) {
      if (value != null) {
        emit(TeamsSuccess(ourResponse: value));
      } else {
        emit(TeamsError());
      }
    });
  }
}
