import 'package:front_end/features/domain/entity/identity/Student.dart';

class StudentModel extends Student {
  StudentModel({
    required super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    super.department,
    super.grade
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      uid: json['uId'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sexual: json['sexual'] as String?,
      phone: json['phone'] as String?,
      department: json['studentInfo']['department'] as String?,
      grade: json['studentInfo']['grade'] as String?
    );
  }

}