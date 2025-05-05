
import 'package:front_end/features/domain/entity/User.dart';

class Student extends User{
  final String department;
  final String grade;

  Student({
    required super.uid,
    required super.name,
    required super.email,
    required super.sexual,
    required super.phone,
    required this.department,
    required this.grade
  });
}