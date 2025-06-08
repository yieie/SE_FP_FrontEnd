import 'package:front_end/features/data/models/identity/admin.dart';
import 'package:front_end/features/data/models/identity/attendee.dart';
import 'package:front_end/features/data/models/identity/judge.dart';
import 'package:front_end/features/data/models/identity/lecturer.dart';
import 'package:front_end/features/data/models/identity/student.dart';
import 'package:front_end/features/data/models/identity/teacher.dart';
import 'package:front_end/features/domain/entity/identity/User.dart';

class UserModelFactory {
  static User fromJson(Map<String, dynamic> json) {
    switch (json['userType']) {
      case 'student':
        return StudentModel.fromJson(json); 
      case 'attendee':
        return AttendeeModel.fromJson(json);
      case 'teacher':
        return TeacherModel.fromJson(json); 
      case 'judge':
        return JudgeModel.fromJson(json);
      case 'lecturer':
        return LecturerModel.fromJson(json);
      case 'admin':
        return AdminModel.fromJson(json);
      default:
        throw Exception('未知角色: ${json['userType']}');
    }
  }
}