import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/admin/add_new_announcement.dart';
import 'package:front_end/features/domain/usecases/admin/edit_old_announcement.dart';
import 'package:front_end/features/presentation/bloc/admin/ann_modify_add_event.dart';
import 'package:front_end/features/presentation/bloc/admin/ann_modify_add_state.dart';

class AnnModifyAddBloc extends Bloc<AnnModifyAddEvent,AnnModifyAddState>{
  final AddNewAnnouncementUseCase _addNewAnnouncementUseCase;
  final EditOldAnnouncementUseCase _editOldAnnouncementUseCase;

  AnnModifyAddBloc(this._addNewAnnouncementUseCase, this._editOldAnnouncementUseCase):super(AnnInitial()){
    on<SubmitNewAnnEvent> (onSubmitNewAnnEvent);

    on<EditOldAnnEvent> (onEditOldAnnEvent);
  }

  void onSubmitNewAnnEvent(SubmitNewAnnEvent event,Emitter emit) async {
    emit(AnnOperateSubmitting());
    final dataState = await _addNewAnnouncementUseCase(title: event.title, content: event.content,poster: event.poster, file: event.file,adminid: event.adminid);
    if(dataState is DataSuccess){
      emit(
        AnnOperateSuccess()
      );
    }
    
    if(dataState is DataFailed){
      emit(
        AnnOperateFailure(dataState.error!)
      );
    }
  }

  void onEditOldAnnEvent(EditOldAnnEvent event, Emitter emit) async {
    emit(AnnOperateSubmitting());
    final dataState = await _editOldAnnouncementUseCase(aid: event.aid,editTile: event.title, editContent: event.content,newPoster: event.poster, newFile: event.file,deletePoster: event.deletePoster,deleteFile: event.deleteFile,adminid: event.adminid);
    if(dataState is DataSuccess){
      emit(
        AnnOperateSuccess()
      );
    }
    
    if(dataState is DataFailed){
      emit(
        AnnOperateFailure(dataState.error!)
      );
    }
  }
}