import 'package:front_end/features/data/models/project.dart';
import 'package:front_end/features/data/models/team.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';

class TeamWithProjectModel extends TeamWithProject{
  final TeamModel team;
  final ProjectModel project;

  TeamWithProjectModel({required this.team, required this.project}):super(team: team,project: project);

  factory TeamWithProjectModel.fromJson(Map<String, dynamic> json){
    return TeamWithProjectModel(
      team: TeamModel.fromJson(json), 
      project: ProjectModel.fromJson(json)
    );
  }
}