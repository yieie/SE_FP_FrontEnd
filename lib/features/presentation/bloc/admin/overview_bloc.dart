import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_overview.dart';
import 'package:front_end/features/presentation/bloc/admin/overview_event.dart';
import 'package:front_end/features/presentation/bloc/admin/overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent,OverviewState> {
  final GetOverviewUseCase _getOverviewUseCase;

  OverviewBloc(this._getOverviewUseCase):super(OverviewInitial()){
    on<getOverviewEvent> (ongetOverviewEvent);
  }

  void ongetOverviewEvent(getOverviewEvent event, Emitter emit) async {
    emit(OverviewLoading());
    final dataState = await _getOverviewUseCase();
    
    if(dataState is DataSuccess){
      emit(
        OverviewLoaded(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      emit(
        OverviewError(dataState.error!)
      );
    }
  }
}