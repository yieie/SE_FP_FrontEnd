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
}