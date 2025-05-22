import 'package:front_end/features/domain/entity/Workshop.dart';

class WorkshopModel extends Workshop {
  const WorkshopModel({
    int ? wsid,
    String ? time,
    String ? topic,
    int ? amount,
    int ? registered,
    String ? lecturerName,
    String ? lecturerTitle
  }): super(
          wsid: wsid,
          time: time,
          topic: topic,
          amount: amount,
          registered: registered,
          lecturerName: lecturerName,
          lecturerTitle: lecturerTitle,
        );

  factory WorkshopModel.fromJson(Map<String, dynamic> json){
    return WorkshopModel(
      wsid: json['id'],
      time: json['date'],
      topic: json['topic'],
      amount: json['maxAmount'],
      registered: json['currentAmount'],
      lecturerName: json['lecturerName'],
      lecturerTitle: json['lecturerTitle']
    );
  }
}