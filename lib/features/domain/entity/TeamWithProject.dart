import 'package:front_end/features/domain/entity/Project.dart';
import 'package:front_end/features/domain/entity/Team.dart';

class TeamWithProject {
  final Team team;
  final Project project;

  TeamWithProject({required this.project, required this.team});
}