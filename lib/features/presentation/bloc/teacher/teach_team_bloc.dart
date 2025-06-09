import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_competition_info_by_teamid.dart';
import 'package:front_end/features/domain/usecases/get_teach_team_list.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_event.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_state.dart';

class TeachTeamBloc extends Bloc<TeachTeamEvent, TeachTeamState>{
  final GetTeachTeamListUseCase _getTeachTeamListUseCase;
  final GetCompetitionInfoByTeamIDUseCase _getCompetitionInfoByTeamIDUseCase;

  TeachTeamBloc(this._getTeachTeamListUseCase,this._getCompetitionInfoByTeamIDUseCase):super(TeamInitial()){
    on<GetTeachTeamListEvent> (onGetTeachTeamListEvent);
    on<GetTeachTeamDetailEvent> (onGetTeachTeamDetailEvent);
  }

  void onGetTeachTeamListEvent(GetTeachTeamListEvent event,Emitter emit) async {
    emit(TeamLoading());
    final dataState = await _getTeachTeamListUseCase(page: event.page, teacherid: event.teacherid);

    if(dataState is DataSuccess){
      emit(
        TeamListLoaded(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      emit(
        TeamError(dataState.error!)
      );
    }
  }

  void onGetTeachTeamDetailEvent(GetTeachTeamDetailEvent event, Emitter emit) async {
    emit(TeamLoading());
    final dataState = await _getCompetitionInfoByTeamIDUseCase(params: event.teamid);

    if(dataState is DataSuccess){
      emit(
        TeamDetailLoaded(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      emit(
        TeamError(dataState.error!)
      );
    }
  }
}