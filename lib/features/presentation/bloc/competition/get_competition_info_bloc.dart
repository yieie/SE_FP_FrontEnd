import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_competition_info_by_uid.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_event.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_state.dart';

class GetCompetitionInfoBloc extends Bloc<GetCompetitionInfoEvent, GetCompetitionInfoState>{
  final GetCompetitionInfoByUIDUseCase _getCompetitionInfoByUIDUseCase;

  GetCompetitionInfoBloc(this._getCompetitionInfoByUIDUseCase):super(InfoInitial()){
    on<GetInfoByUIDEvent> (onGetInfoByUID);
  }

  void onGetInfoByUID(GetInfoByUIDEvent event, Emitter emit) async {
    emit(InfoLoading());
    final datastate= await _getCompetitionInfoByUIDUseCase(params: event.uid);

    if(datastate is DataSuccess){
      emit(
        InfoLoaded(datastate.data!)
      );
    }

    if(datastate is DataFailed){
      emit(
        InfoError(datastate.error!)
      );
    }
  }
}