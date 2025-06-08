import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:file_picker/file_picker.dart';

abstract class AnnModifyAddEvent {}

class SubmitNewAnnEvent extends AnnModifyAddEvent{
  final String title;
  final String content;
  final List<PlatformFile> poster;
  final List<PlatformFile> file;
  final String adminid;

  SubmitNewAnnEvent({required this.title, required this.content, required this.poster,required this.file, required this.adminid});
}

class EditOldAnnEvent extends AnnModifyAddEvent{
  final int aid;
  final String title;
  final String content;
  final List<PlatformFile> poster;
  final List<PlatformFile> file;
  final List<String> deletePoster;
  final List<({String fileName, String fileUrl})> deleteFile;
  final String adminid;
  
  
  EditOldAnnEvent({required this.aid, required this.title, required this.content, required this.poster,required this.file,required this.deletePoster, required this.deleteFile, required this.adminid});
}

// class DeleteAnnEvent extends AnnModifyAddEvent{
//   final int aid;
  
//   DeleteAnnEvent(this.aid);
// }