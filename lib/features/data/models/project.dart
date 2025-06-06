import 'package:front_end/features/domain/entity/Project.dart';

class ProjectModel extends Project {
  ProjectModel({
    super.name,
    super.workID,
    super.abstract,
    super.sdgs,
    super.url,
    super.introductionFile,
    super.affidavitFile,
    super.consentFile
  });

  // 待確認API文件欄位名稱
  factory ProjectModel.fromJson(Map<String , dynamic> json){
    return ProjectModel(
      name: json['teaminfo']['workName'] as String,
      workID: json['workId'] as String, //沒有這個欄位
      abstract: json['teaminfo']['workAbstract'] as String,
      sdgs: json['teaminfo']['sdgs'] as String,
      url: json['teaminfo']['workUrls'] as List<String>,
      introductionFile: json['teaminfo']['workintroduction'] as String,
      affidavitFile: json['teaminfo']['workaffidavit'] as String,
      consentFile: json['teaminfo']['workconsent'] as String
    );
  }
}