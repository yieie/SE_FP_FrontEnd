import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_workshop.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_list_event.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_list_state.dart';

class WorkshopBloc extends Bloc<WorkshopEvent, WorkshopState>{
  final GetWorkshopUseCase _getWorkshop;

  WorkshopBloc(this._getWorkshop): super(WorkshopListInitial()) {
    on<GetWorkshop> (onGetWorkshop);
  }

  void onGetWorkshop(GetWorkshop event, Emitter<WorkshopState> emit) async {
    final datastate = await _getWorkshop();

    if(datastate is DataSuccess) {
      emit(
        WorkshopListDone(workshop: datastate.data!)
      );
    }

    if(datastate is DataFailed) {
      emit(
        WorkshopListError(error: datastate.error!)
      );
    }
  }
}