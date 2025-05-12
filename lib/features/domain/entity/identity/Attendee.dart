
import 'package:front_end/features/domain/entity/identity/Student.dart';

class Attendee extends Student{
  final String ? studentCard;

  Attendee({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    super.department,
    super.grade,
    this.studentCard
  });
}