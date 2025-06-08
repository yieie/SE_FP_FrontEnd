import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';

abstract class PastProjectState {}

class PastProjectInitial extends PastProjectState{}

class PastProjectLoading extends PastProjectState{}

class PastProjectListLoaded extends PastProjectState{
  List<TeamWithProject> teamwithprojectlist;

  PastProjectListLoaded(this.teamwithprojectlist);
}

class PastProjectDetailLoaded extends PastProjectState{
  TeamWithProject teamWithProject;

  PastProjectDetailLoaded(this.teamWithProject);
}

class PastProjectError extends PastProjectState{
  DioException error;
  PastProjectError(this.error);
}