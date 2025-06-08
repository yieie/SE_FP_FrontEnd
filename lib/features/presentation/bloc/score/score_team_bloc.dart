import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_competition_info_by_teamid.dart';
import 'package:front_end/features/domain/usecases/scoring_team.dart';
import 'package:front_end/features/presentation/bloc/score/score_team_event.dart';
import 'package:front_end/features/presentation/bloc/score/score_team_state.dart';

class ScoreTeamBloc extends Bloc<ScoreTeamEvent,ScoreTeamState>{
  final GetCompetitionInfoByTeamIDUseCase _competitionInfoByTeamIDUseCase;
  final ScoringTeamUseCase _scoringTeamUseCase;

  ScoreTeamBloc(this._competitionInfoByTeamIDUseCase, this._scoringTeamUseCase):super(ScoreInitial()){
    on<LoadTeamInfoEvent> (onLoadTeamInfoEvent);
    on<SubmitScoreEvent> (onSubmitScoreEvent);
  }

  void onLoadTeamInfoEvent(LoadTeamInfoEvent event, Emitter emit) async {
    final dataState = await _competitionInfoByTeamIDUseCase(params: event.teamid);

    if(dataState is DataSuccess){
      emit(
        ScoreLoaed(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      emit(
        ScoreFailure(dataState.error!)
      );
    }
  }

  void onSubmitScoreEvent(SubmitScoreEvent event, Emitter emit) async {
    final dataState = await _scoringTeamUseCase(score: event.score, judgeid: event.judgeid, workid: event.workid);

    if(dataState is DataSuccess){
      emit(
        ScoreSuccess()
      );
    }

    if(dataState is DataFailed){
      emit(
        ScoreFailure(dataState.error!)
      );
    }
  }
}