import 'package:front_end/features/data/models/identity/attendee.dart';
import 'package:front_end/features/data/models/identity/teacher.dart';
import 'package:front_end/features/domain/entity/Team.dart';
import 'package:front_end/features/domain/entity/identity/Teacher.dart';

class TeamModel extends Team{
  const TeamModel({
    super.teamID,
    super.name,
    super.type,
    super.rank,
    super.teacher,
    super.members
  });
  
  factory TeamModel.fromJson(Map<String, dynamic> json){
    return TeamModel(
      teamID: json['teamId'] ?? '', 
      name: json['teamInfo']?['teamName'] ?? json['teamName'] ?? '',
      type: json['teamInfo']?['teamType'] ?? json['teamType'] ?? '',
      rank: json['teamRank'] ?? json['teamInfo']?['rank'],
      teacher: json['advisorInfo'] != null ? TeacherModel.fromJson(json['advisorInfo']) : json['advisor'] != null ? TeacherModel(name: json["advisor"]) : null,
      members:  (json['memberInfo'] as List<dynamic>?)?.map((json) => AttendeeModel.fromJson(json as Map<String, dynamic>)).toList() ?? 
                (json['members'] as List<dynamic>?)?.map((json) => AttendeeModel.fromJson(json as Map<String, dynamic>)).toList()
    );
  }
  
  Map<String, dynamic> toJson(){
    return {
      'tid': teamID,
      'name': name,
      'type': type,
      'rank' : rank,
      'uid' : teacher
    };
  }
}