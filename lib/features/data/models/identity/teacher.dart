import 'package:front_end/features/domain/entity/identity/Teacher.dart';

class TeacherModel extends Teacher{
  TeacherModel({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    super.department,
    super.organization,
    super.title
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      uid: json['uId'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sexual: json['sexual'] as String?,
      phone: json['phone'] as String?,
      department: json['teacherInfo']['department'] as String?,
      organization: json['teacherInfo']['organization'] as String?,
      title: json['teacherInfo']['title'] as String?
    );
  }
}