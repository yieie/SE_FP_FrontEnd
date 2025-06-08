import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/entity/AnnouncementList.dart';
import 'package:file_picker/file_picker.dart';

abstract class AnnRepository {
  
  Future<DataState<AnnouncementList>> get10announcement(int page);

  Future<DataState<Announcement>> getdetailannouncement(int aid);
  
  Future<DataState<ResponseMessage>> addNewAnnouncement(Announcement ann);

  Future<DataState<ResponseMessage>> uploadAnnouncementPoster(PlatformFile file, int aid);

  Future<DataState<ResponseMessage>> uploadAnnouncementFile(PlatformFile file, int aid);

  Future<DataState<ResponseMessage>> editOldAnnouncement(Announcement ann);

  Future<DataState<ResponseMessage>> deleteAnnouncementPoster(int aid,String url);

  Future<DataState<ResponseMessage>> deleteAnnouncementFile(int aid,String name ,String url);
}