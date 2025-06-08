import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_competition_info_by_teamid.dart';
import 'package:front_end/features/domain/usecases/get_past_project.dart';
import 'package:front_end/features/presentation/bloc/past_project_event.dart';
import 'package:front_end/features/presentation/bloc/past_project_state.dart';

class PastProjectBloc extends Bloc<PastProjectEvent, PastProjectState> {
  final GetPastProjectUseCase _getPastProjectUserCase;
  final GetCompetitionInfoByTeamIDUseCase _getCompetitionInfoByTeamIDUseCase;

  PastProjectBloc(this._getPastProjectUserCase,this._getCompetitionInfoByTeamIDUseCase):super(PastProjectInitial()){
    on<GetPastProjectbyYearAndTeamtypeEvent> (onGetPastProjectbyYearAndTeamtypeEvent);

    on<GetPastProjectDetailbyTeamIDEvent> (onGetPastProjectDetailbyTeamIDEvent);
  }

  void onGetPastProjectbyYearAndTeamtypeEvent(GetPastProjectbyYearAndTeamtypeEvent event, Emitter emit) async {
    emit(PastProjectLoading());
    final dataState = await _getPastProjectUserCase(year: event.year, teamType: event.teamType);

    if(dataState is DataSuccess){
      emit(
        PastProjectListLoaded(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      emit(
        PastProjectError(dataState.error!)
      );
    }
  }

  void onGetPastProjectDetailbyTeamIDEvent(GetPastProjectDetailbyTeamIDEvent event, Emitter emit) async {
    emit(PastProjectLoading());
    final dataState = await _getCompetitionInfoByTeamIDUseCase(params: event.teamid);

    if(dataState is DataSuccess){
      emit(
        PastProjectDetailLoaded(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      emit(
        PastProjectError(dataState.error!)
      );
    }
  }
}