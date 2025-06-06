
import 'package:front_end/features/domain/entity/identity/User.dart';

class Student extends User{
  final String ? department;
  final String ? grade;

  Student({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    this.department,
    this.grade
  });
}