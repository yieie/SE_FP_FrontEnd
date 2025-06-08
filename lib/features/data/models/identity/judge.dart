import 'package:front_end/features/domain/entity/identity/Judge.dart';

class JudgeModel extends Judge{
  JudgeModel({
    required super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    super.title
  });

  factory JudgeModel.fromJson(Map<String, dynamic> json) {
    return JudgeModel(
      uid: json['uId'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sexual: json['sexual'] as String?,
      phone: json['phone'] as String?,
      title: json['judgeInfo']['title'] as String?
    );
  }

  factory JudgeModel.fromEntity(Judge judge){
    return JudgeModel(
      uid: judge.uid,
      name: judge.name,
      email: judge.email,
      sexual: judge.sexual,
      phone: judge.phone,
      title: judge.title
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "uId": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "sexual": sexual,
      "judgeInfo": {
          "title": title
      },
    };
  }
}