import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class AddNewAnnouncementUseCase implements UseCase<DataState<ResponseMessage>,void>{
  final AnnRepository _annRepository;

  AddNewAnnouncementUseCase(this._annRepository);

  @override
  Future<DataState<ResponseMessage>> call({void params,String? title,String? content ,List<PlatformFile>? poster,List<PlatformFile>? file ,String? adminid}) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final Announcement ann = Announcement(title: title,content: content,time: formattedDate,uid: adminid);
    final essential = await _annRepository.addNewAnnouncement(ann);
    if(essential is DataFailed){
      return essential;
    }

    if(poster != null){
      for(int i=0;i<poster.length;i++){
        final upload = await _annRepository.uploadAnnouncementPoster(poster[i], essential.data!.extraData!['aId']);
        if(upload is DataFailed){
          return upload;
        }
      }
    }
    if(file != null){
      for(int i=0;i<file.length;i++){
        final upload = await _annRepository.uploadAnnouncementPoster(file[i], essential.data!.extraData!['aId']);
        if(upload is DataFailed){
          return upload;
        }
      }
    }
    return essential;
  }

}