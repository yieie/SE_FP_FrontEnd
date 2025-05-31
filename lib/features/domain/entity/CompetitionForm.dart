import 'package:file_picker/file_picker.dart';


class CompetitionForm {
  final String ? teamName;
  final String ? type;
  final String ? leader;
  final List<({String studentID, PlatformFile idCard})> ? members;
  final String ? teacherID;

  final String ? workName;
  final String ? abstract;
  final String ? sdgs;
  final PlatformFile ? introductionFile;
  final PlatformFile ? consentFile;
  final PlatformFile ? affidavitFile;
  final List<String> ? url;

  const CompetitionForm({
    this.teamName,
    this.type,
    this.leader,
    this.members,
    this.teacherID,
    this.workName,
    this.abstract,
    this.sdgs,
    this.introductionFile,
    this.consentFile,
    this.affidavitFile,
    this.url
  });
}