import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';

abstract class TeachTeamState{}

class TeamInitial extends TeachTeamState{}

class TeamLoading extends TeachTeamState{}

class TeamListLoaded extends TeachTeamState{
  TeamWithProjectList teamWithProjectList;

  TeamListLoaded(this.teamWithProjectList);
}

class TeamDetailLoaded extends TeachTeamState{
  TeamWithProject teamWithProject;

  TeamDetailLoaded(this.teamWithProject);
}

class TeamError extends TeachTeamState{
  DioException error;

  TeamError(this.error);
}