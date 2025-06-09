import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';

abstract class VertifyTeamState {}

class VertifyTeamInitial extends VertifyTeamState {}

class VertifyTeamLoading extends VertifyTeamState {}

class VertifyTeamListLoaded extends VertifyTeamState {
  TeamWithProjectList teamwithprojectlist;

  VertifyTeamListLoaded(this.teamwithprojectlist);
}

class VertifyTeamDetailLoaded extends VertifyTeamState{
  TeamWithProject teamWithProject;

  VertifyTeamDetailLoaded(this.teamWithProject);
}

class VertifyTeamSubmitting extends VertifyTeamState {}

class VertifyTeamSuccess extends VertifyTeamState {}

class VertifyTeamError extends VertifyTeamState{
  DioException error;

  VertifyTeamError(this.error);
}