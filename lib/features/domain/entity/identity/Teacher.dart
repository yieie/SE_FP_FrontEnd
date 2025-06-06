
import 'package:front_end/features/domain/entity/identity/User.dart';

class Teacher extends User{
  final String ? department;
  final String ? organization;
  final String ? title;

  Teacher({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    this.department,
    this.organization,
    this.title
  });
}