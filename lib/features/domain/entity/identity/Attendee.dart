
import 'package:front_end/features/domain/entity/identity/Student.dart';

class Attendee extends Student{
  final String ? studentCard;
  final String ? teamID;
  final String ? workID;

  Attendee({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    super.department,
    super.grade,
    this.studentCard,
    this.teamID,
    this.workID
  });
}