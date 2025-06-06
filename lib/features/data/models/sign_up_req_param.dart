

import 'package:front_end/features/domain/entity/identity/Student.dart';

class SignupReqParams extends Student{
  final String? password;
  SignupReqParams({
    super.uid = '',
    this.password,
    super.name = '',
    super.email = '',
    super.sexual = '',
    super.phone = '',
    super.department = '',
    super.grade = ''
  });

  // 修改 copyWith 方法
  SignupReqParams copyWith({
    String? uid,
    String? password,
    String? name,
    String? email,
    String? sexual,
    String? phone,
    String? department,
    String? grade,
  }) {
    return SignupReqParams(
        uid: uid ?? this.uid,
        password: password ?? this.password,
        name: name ?? this.name,
        email: email ?? this.email,
        sexual: sexual ?? this.sexual,
        phone: phone ?? this.phone,
        department: department ?? this.department,
        grade: grade ?? this.grade,
    );
  }

  factory SignupReqParams.fromJson(Map<String, dynamic> json){
    return SignupReqParams(
      uid: json['id'] as String, 
      password: json['password'] as String,
      name: json['name'] as String, 
      email: json['email'] as String, 
      sexual: json['sexual'] as String, 
      phone: json['phone'] as String, 
      department: json['department'] as String, 
      grade: json['grade'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'password': password,
      'name': name,
      'email': email,
      'sexual': sexual,
      'phone': phone,
      'department': department,
      'grade': grade,
      'userType': 'student' 
    };
  }
}