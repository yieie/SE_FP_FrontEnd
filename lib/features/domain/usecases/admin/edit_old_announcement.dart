

import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class EditOldAnnouncementUseCase implements UseCase<DataState<ResponseMessage>,void>{
  final AnnRepository _annRepository;

  EditOldAnnouncementUseCase(this._annRepository);

  @override
  Future<DataState<ResponseMessage>> call({void params,String? editTile,String? editContent,List<String>? deletePoster, 
    List<({String fileName, String fileUrl})>? deleteFile,List<PlatformFile>? newPoster,List<PlatformFile>? newFile , int? aid,String? adminid}) async {
    
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final Announcement ann = Announcement(aid: aid,title: editTile, content: editContent,time: formattedDate,uid: adminid); 
    final essential = await _annRepository.editOldAnnouncement(ann);
    if(essential is DataFailed){
      return essential;
    }
    if(deletePoster !=null){
      for(int i=0; i<deletePoster.length;i++){
        final delete = await _annRepository.deleteAnnouncementPoster(aid!, deletePoster[i]);
        if(delete is DataFailed){
          return delete;
        }
      }
    }
    
    if(deleteFile !=null){
      for(int i=0; i<deleteFile.length;i++){
        final delete = await _annRepository.deleteAnnouncementFile(aid!, deleteFile[i].fileName,deleteFile[i].fileUrl);
        if(delete is DataFailed){
          return delete;
        }
      }
    }

    if(newPoster != null){
      for(int i=0;i<newPoster.length;i++){
        final upload = await _annRepository.uploadAnnouncementPoster(newPoster[i], aid!);
        if(upload is DataFailed){
          return upload;
        }
      }
    }
    if(newFile != null){
      for(int i=0;i<newFile.length;i++){
        final upload = await _annRepository.uploadAnnouncementFile(newFile[i], aid!);
        if(upload is DataFailed){
          return upload;
        }
      }
    }
    return essential;
  }

}