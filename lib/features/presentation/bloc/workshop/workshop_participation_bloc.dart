import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_workshop_participation.dart';
import 'package:front_end/features/domain/usecases/join_workshop.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_event.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_state.dart';
import 'package:front_end/features/presentation/widget/basic/basic_toast.dart';

class WorkshopParticipationBloc extends Bloc<WorkshopParticipationEvent,WorkshopParticipationState>{
  final GetWorkshopParticipationUseCase _getWorkshopParticipation;
  final JoinWorkshopUseCase _joinWorkshop;

  WorkshopParticipationBloc(this._getWorkshopParticipation, this._joinWorkshop) : super(ParticipationInitial()){
    on<GetWorkshopParticipation> (onGetWorkshopParticipation);
    on<JoinWorkshop> (onJoinWorkshop);
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

  void onJoinWorkshop(JoinWorkshop event, Emitter<WorkshopParticipationState> emit) async {
    emit(
      JoinSubmitting(uid: event.uid, wsid: event.wsid)
    );

    final datastate = await _joinWorkshop(uid: event.uid, wsid: event.wsid);

    if(datastate is DataSuccess){
      final upatedList = await _getWorkshopParticipation(params: event.uid);
      emit(JoinSuccess());
      emit(
        ParticipationLoaded(participation: upatedList.data!)
      );
    }

    if(datastate is DataFailed){
      emit(
        JoinError(error: datastate.error!)
      );
    }
  }
}