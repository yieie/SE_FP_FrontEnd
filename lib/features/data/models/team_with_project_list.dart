

import 'package:front_end/features/data/models/team_with_project.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';

class TeamWithProjectListModel extends TeamWithProjectList{
  TeamWithProjectListModel({
    required super.page,
    required super.totalPages,
    required List<TeamWithProjectModel> teamwithprojectlist
  }):super(teamwithprojectlist: teamwithprojectlist);
}