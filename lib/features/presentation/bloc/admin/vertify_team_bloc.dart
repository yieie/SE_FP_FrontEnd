import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/admin/get_vertify_team.dart';
import 'package:front_end/features/domain/usecases/admin/update_team_state.dart';
import 'package:front_end/features/domain/usecases/get_competition_info_by_teamid.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_event.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_state.dart';

class VertifyTeamBloc extends Bloc<VertifyTeamEvent,VertifyTeamState>{
  final GetVertifyTeamUseCase _getVertifyTeamUseCase;
  final GetCompetitionInfoByTeamIDUseCase _getCompetitionInfoByTeamIDUseCase;
  final UpdateTeamStateUseCase _updateTeamStateUseCase;

  VertifyTeamBloc(this._getVertifyTeamUseCase, this._getCompetitionInfoByTeamIDUseCase,this._updateTeamStateUseCase):super(VertifyTeamInitial()){
    on<GetVertifyTeamListEvent> (onGetVertifyTeamListEvent);

    on<GetVertifyTeamDetailEvent> (onGetVertifyTeamDetailEvent);

    on<SubmitStateEvent> (onSubmitStateEvent);
  }

  void onGetVertifyTeamListEvent(GetVertifyTeamListEvent event, Emitter emit) async {
    emit(VertifyTeamLoading());
    final dataState = await _getVertifyTeamUseCase(page: event.page);

    if(dataState is DataSuccess){
      emit(VertifyTeamListLoaded(dataState.data!));
    }

    if(dataState is DataFailed){
      emit(VertifyTeamError(dataState.error!));
    }
  }

  void onGetVertifyTeamDetailEvent(GetVertifyTeamDetailEvent event, Emitter emit) async {
    emit(VertifyTeamLoading());
    final dataState = await _getCompetitionInfoByTeamIDUseCase(params: event.teamid);

    if(dataState is DataSuccess){
      emit(VertifyTeamDetailLoaded(dataState.data!));
    }

    if(dataState is DataFailed){
      emit(VertifyTeamError(dataState.error!));
    }
  }

  void onSubmitStateEvent(SubmitStateEvent event, Emitter emit) async {
    emit(VertifyTeamSubmitting());
    final dataState = await _updateTeamStateUseCase(teamid: event.teamid, state: event.state, message: event.state);

    if(dataState is DataSuccess){
      emit(VertifyTeamSuccess());
    }

    if(dataState is DataFailed){
      emit(VertifyTeamError(dataState.error!));
    }

  }
}