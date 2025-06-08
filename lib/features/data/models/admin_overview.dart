import 'package:front_end/features/domain/entity/Admin_Overview.dart';

class AdminOverviewModel extends AdminOverview {
  AdminOverviewModel({
    required super.totaluser,
    required super.studentAmount,
    required super.attendeeAmount,
    required super.teacherAmount,
    required super.lecturerAmount,
    required super.judgeAmount,
    required super.totalTeam,
    required super.verified,
    required super.needVerify,
    required super.needReAttached
  });

  factory AdminOverviewModel.fromJson(Map<String, dynamic> json){
    return AdminOverviewModel(
      totaluser: json['userManage']?['totalUser'] ?? -1, 
      studentAmount: json['userManage']?['stuAmount'] ?? -1, 
      attendeeAmount: json['userManage']?['attendeeAmount'] ?? -1, 
      teacherAmount: json['userManage']?['techerAmount'] ?? -1, 
      lecturerAmount: json['userManage']?['lecturerAmount'] ?? -1, 
      judgeAmount: json['userManage']?['judgeAmount'] ?? -1, 
      totalTeam: json['workState']?['totalTeam'] ?? -1, 
      verified: json['workState']?['accepted'] ?? -1, 
      needVerify: json['workState']?['pending'] ?? -1,
      needReAttached: json['workState']?['supplementary'] ?? -1
    );
  } 
}