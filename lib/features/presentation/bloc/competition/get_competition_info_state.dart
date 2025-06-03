import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';

abstract class GetCompetitionInfoState {}

class InfoInitial extends GetCompetitionInfoState {}

class InfoLoading extends GetCompetitionInfoState {}

class InfoLoaded extends GetCompetitionInfoState {
  TeamWithProject info;

  InfoLoaded(this.info);
}

class InfoError extends GetCompetitionInfoState {
  DioException error;

  InfoError(this.error);
}