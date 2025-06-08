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
    super.consentFile,
    super.score
  });

  // 待確認API文件欄位名稱
  factory ProjectModel.fromJson(Map<String , dynamic> json){
    return ProjectModel(
      name: json['teaminfo']?['workName'] ?? json['workName'] ?? '',
      workID: json['workId'] ?? '' , 
      abstract: json['teaminfo']?['workAbstract'] ?? '',
      sdgs: json['teaminfo']?['sdgs'] ?? '',
      url: json['teaminfo']?['workUrls'] ,
      introductionFile: json['teaminfo']?['workintroduction'] ?? '',
      affidavitFile: json['teaminfo']?['workaffidavit'] ?? '',
      consentFile: json['teaminfo']?['workconsent'] ?? ''
    );
  }
}