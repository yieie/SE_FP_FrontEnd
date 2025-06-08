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

  factory TeacherModel.fromEntity(Teacher teacher){
    return TeacherModel(
      uid: teacher.uid,
      name: teacher.name,
      email: teacher.email,
      sexual: teacher.sexual,
      phone: teacher.phone,
      department: teacher.department,
      organization: teacher.organization,
      title: teacher.title
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "uId": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "sexual": sexual,
      "teacherInfo": {
        "department": department,
        "organization": organization,
        "title": title
      },
    };
  }
}