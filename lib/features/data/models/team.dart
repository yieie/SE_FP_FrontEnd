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
  
  //待確認API文件json欄位
  factory TeamModel.fromJson(Map<String, dynamic> json){
    return TeamModel(
      teamID: json['tid'], //沒有這個欄位
      name: json['teaminfo']['teamName'],
      type: json['teaminfo']['teamType'],
      rank: json['rank'],
      teacher: TeacherModel.fromJson(json['advisorInfo']),
      members: json['memberInfo'].map((json) => AttendeeModel.fromJson(json)).toList()
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