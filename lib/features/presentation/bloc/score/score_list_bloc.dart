import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_score_list.dart';
import 'package:front_end/features/domain/usecases/scoring_team.dart';
import 'package:front_end/features/presentation/bloc/score/score_list_event.dart';
import 'package:front_end/features/presentation/bloc/score/score_list_state.dart';

class ScoreListBloc extends Bloc<ScoreListEvent,ScoreListState> {
  final GetScoreListUseCase _getScoreListUseCase;
  final ScoringTeamUseCase _scoringTeamUseCase;

  ScoreListBloc(this._getScoreListUseCase,this._scoringTeamUseCase):super(ScoreListInitial()){
    on<GetScoreList> (onGetScoreList);
    on<ScoringTeam> (onScoringTeam);
  }

  void onGetScoreList(GetScoreList event, Emitter emit) async {
    emit(ScoreListLoading());
    final dataState = await _getScoreListUseCase(params: event.getpage);

    if(dataState is DataSuccess && dataState.data != null){
      emit(
        ScoreListLoaded(teamwithprojectlist: dataState.data!)
      );
    }

    if(dataState is DataFailed){
      emit(
        ScoreListError(dataState.error!)
      );
    }
  }

  void onScoringTeam(ScoringTeam event, Emitter emit) async {
    final dataState = await _scoringTeamUseCase(score: event.score, judgeid: event.judgeid, workid: event.workid);

    if(dataState is DataSuccess && dataState.data != null){
      emit(
        ScoringSuccess(dataState.data!.extraData!['score'])
      );
    }

    if(dataState is DataFailed){
      emit(
        ScoreListError(dataState.error!)
      );
    }
  }
}