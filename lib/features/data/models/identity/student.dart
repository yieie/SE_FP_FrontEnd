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

  factory StudentModel.fromEntity(Student student){
    return StudentModel(
      uid: student.uid,
      name: student.name,
      email: student.email,
      sexual: student.sexual,
      phone: student.phone,
      department: student.department,
      grade: student.grade
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "uId": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "sexual": sexual,
      "studentInfo": {
        "department": department,
        "grade": grade
      },
    };
  }

}