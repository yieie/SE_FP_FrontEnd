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
    super.score,
    super.state
  });

  // 待確認API文件欄位名稱
  factory ProjectModel.fromJson(Map<String , dynamic> json){
    return ProjectModel(
      name: json['teamInfo']?['workName'] ?? json['workName'] ?? '',
      workID: json['workId'] ?? '' , 
      abstract: json['teamInfo']?['workAbstract'] ?? '',
      sdgs: json['teamInfo']?['sdgs'] ?? '',
      url: (json['teamInfo']?['workUrls'] != null)? List<String>.from(json['teamInfo']?['workUrls']): [],
      introductionFile: json['teamInfo']?['workIntroduction'] ?? '',
      affidavitFile: json['teamInfo']?['workAffidavit'] ?? '',
      consentFile: json['teamInfo']?['workConsent'] ?? '',
      score: json['score'],
      state: json['state'] ?? json['teamInfo']?['workState']
    );
  }
}