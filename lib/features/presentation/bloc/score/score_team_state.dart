import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';

abstract class ScoreTeamState {}

class ScoreInitial extends ScoreTeamState {}

class ScoreLoaed extends ScoreTeamState{
  final TeamWithProject teamWithProject;

  ScoreLoaed(this.teamWithProject);
}

class ScoreSubmit extends ScoreTeamState{}

class ScoreSuccess extends ScoreTeamState{}

class ScoreFailure extends ScoreTeamState{
  DioException error;

  ScoreFailure(this.error);
}