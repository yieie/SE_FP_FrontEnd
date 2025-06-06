import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/get_10_announcement.dart';
import 'package:front_end/features/domain/usecases/get_detail_announcement.dart';
import 'package:front_end/features/presentation/bloc/ann_event.dart';
import 'package:front_end/features/presentation/bloc/ann_state.dart';

class AnnBloc extends Bloc<AnnEvent,AnnState>{
  final Get10AnnouncementUseCase _get10announcementUseCase;
  final GetDetailAnnouncementUseCase _getDetailAnnouncementUseCase;
  
  AnnBloc(this._get10announcementUseCase, this._getDetailAnnouncementUseCase) : super(const AnnouncementLoading()){
    on<Get10Announcement> (onGet10Announcement);
    on<GetDetailAnnouncement>  (onGetDetailAnnouncement);
  }

  void onGet10Announcement(Get10Announcement event, Emitter<AnnState> emit) async {
    final dataState = await _get10announcementUseCase(params: event.getpage);
  
    if(dataState is DataSuccess) {
      emit(
        AnnouncementDone(dataState.data!, currentPage: event.getpage)
      );
    }

    if(dataState is DataFailed) {
      emit(
        AnnouncementError(dataState.error!)
      );
    }
  }

  void onGetDetailAnnouncement(GetDetailAnnouncement event, Emitter<AnnState> emit) async {
    emit(AnnouncementLoading());
    final dataState = await _getDetailAnnouncementUseCase(params: event.getaid);

    if(dataState is DataSuccess && dataState.data != null){
      emit(
        AnnouncementDetailDone(dataState.data!, aid: event.getaid)
      );
    }

    if(dataState is DataFailed){
      emit(
        AnnouncementError(dataState.error!)
      );
    }
  }
}