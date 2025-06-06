import 'package:front_end/features/domain/entity/TeamWithProject.dart';

class TeamWithProjectList {
  int page;
  int totalPages;
  List<TeamWithProject> teamwithprojectlist;

  TeamWithProjectList({required this.page, required this.totalPages, required this.teamwithprojectlist});
}