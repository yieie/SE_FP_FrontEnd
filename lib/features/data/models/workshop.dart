import 'package:front_end/features/domain/entity/Workshop.dart';

class WorkshopModel extends Workshop {
  const WorkshopModel({
    String ? wsid,
    String ? time,
    String ? topic,
    int ? amount,
    int ? registered,
    String ? lecturerName,
    String ? lecturerTitle
  });

  //待確認API文件json欄位名稱
  factory WorkshopModel.fromJson(Map<String, dynamic> json){
    return WorkshopModel(
      wsid: json['wsid'],
      time: json['time'],
      topic: json['topic'],
      amount: json['maxAmount'],
      registered: json['currentAmount'],
      lecturerName: json['lectureName'],
      lecturerTitle: json['lectureTitle']
    );
  }
}