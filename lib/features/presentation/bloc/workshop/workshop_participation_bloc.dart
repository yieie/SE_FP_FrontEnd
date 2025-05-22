import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_workshop_participation.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_event.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_state.dart';

class WorkshopParticipationBloc extends Bloc<WorkshopParticipationEvent,WorkshopParticipationState>{
  final GetWorkshopParticipationUseCase _getWorkshopParticipation;

  WorkshopParticipationBloc(this._getWorkshopParticipation) : super(ParticipationInitial()){
    on<GetWorkshopParticipation> (onGetWorkshopParticipation);
  }

  void onGetWorkshopParticipation(GetWorkshopParticipation event, Emitter<WorkshopParticipationState> emit) async {
    final datastate = await _getWorkshopParticipation(params: event.uid);

    if(datastate is DataSuccess){
      emit(
        ParticipationLoaded(participation: datastate.data!)
      );
    }

    if(datastate is DataFailed){
      emit(
        ParticipationError(error: datastate.error!)
      );
    }
  }
}