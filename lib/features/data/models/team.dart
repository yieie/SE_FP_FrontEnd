import 'package:front_end/features/domain/entity/Team.dart';

class TeamModel extends Team{
  const TeamModel({
    String ? teamID,
    String ? name,
    String ? type,
    String ? leader,
    String ? rank,
    String ? teacher
  });
  
  //待確認API文件json欄位
  factory TeamModel.fromJson(Map<String, dynamic> json){
    return TeamModel(
      teamID: json['tid'],
      name: json['name'],
      type: json['type'],
      leader: json['leader'],
      rank: json['rank'],
      teacher: json['uid']
    );
  }
  
  Map<String, dynamic> toJson(){
    return {
      'tid': teamID,
      'name': name,
      'type': type,
      'leader' : leader,
      'rank' : rank,
      'uid' : teacher
    };
  }
}