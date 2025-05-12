import 'package:front_end/features/domain/entity/identity/Attendee.dart';
import 'package:front_end/features/domain/entity/Project.dart';
import 'package:front_end/features/domain/entity/identity/Teacher.dart';
import 'package:front_end/features/domain/entity/Team.dart';

class CompetitionForm {
  final Team team;
  final Project project;
  final List<Attendee> attendees;
  final Teacher teacher;

  const CompetitionForm({
    required this.team,
    required this.project,
    required this.attendees,
    required this.teacher
  });
}