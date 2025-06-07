import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';

abstract class ScoreListState {}

class ScoreListInitial extends ScoreListState{}

class ScoreListLoading extends ScoreListState{}

class ScoreListLoaded extends ScoreListState{
  final TeamWithProjectList teamwithprojectlist;
  ScoreListLoaded({required this.teamwithprojectlist});
}

class ScoreListError extends ScoreListState{
  final DioException error;

  ScoreListError(this.error);
}

class ScoringSubmit extends ScoreListState{}

class ScoringSuccess extends ScoreListState{
  final double score;
  ScoringSuccess(this.score);
}
