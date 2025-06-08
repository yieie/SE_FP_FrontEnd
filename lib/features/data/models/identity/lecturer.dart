import 'package:front_end/features/domain/entity/identity/Lecturer.dart';

class LecturerModel extends Lecturer{
  LecturerModel({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    super.title
  });

  factory LecturerModel.fromJson(Map<String, dynamic> json){
    return LecturerModel(
      uid: json['uid'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sexual: json['sexual'] as String?,
      phone: json['phone'] as String?,
      title: json['lecturerInfo']['title'] as String?
    );
  }

  factory LecturerModel.fromEntity(Lecturer lecturer){
    return LecturerModel(
      uid: lecturer.uid,
      name: lecturer.name,
      email: lecturer.email,
      sexual: lecturer.sexual,
      phone: lecturer.phone,
      title: lecturer.title
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "uId": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "sexual": sexual,
      "lecturerInfo": {
          "title": title
      },
    };
  }
}