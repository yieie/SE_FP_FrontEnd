import 'package:front_end/features/domain/entity/CompetitionForm.dart';

class CompetitionFormModel extends CompetitionForm {
  CompetitionFormModel({
    super.teamName,
    super.type,
    super.leader,
    super.members,
    super.teacherID,
    super.workName,
    super.abstract,
    super.sdgs,
    super.introductionFile,
    super.consentFile,
    super.affidavitFile,
    super.url
  });

  factory CompetitionFormModel.fromEntity(CompetitionForm form){
    return CompetitionFormModel(
      teamName:  form.teamName,
      type: form.type,
      leader: form.leader,
      members: form.members,
      teacherID: form.teacherID,
      workName: form.workName,
      abstract: form.abstract,
      sdgs: form.sdgs,
      introductionFile: form.introductionFile,
      consentFile: form.consentFile,
      affidavitFile: form.affidavitFile,
      url: form.url
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "teamName": teamName,
      "teamType": type,
      "workName": workName,
      "workAbstract": abstract,
      "workUrls":url,
      "sdgs":sdgs,
      "numberOfMember": members!.length,
      "teamMembers": members!.map((e) => e.studentID).toList(),
      "teacherId":teacherID
    };
  }
}