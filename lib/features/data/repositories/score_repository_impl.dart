import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/score_api_service.dart';
import 'package:front_end/features/data/models/team_with_project_list.dart';
import 'package:front_end/features/domain/repositories/score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final ScoreApiService _scoreApiService;
  
  ScoreRepositoryImpl(this._scoreApiService);
  
  @override
  Future<DataState<TeamWithProjectListModel>> getScoreList(int page) async {
    final httpResponse = await _scoreApiService.getScoreList(page);

    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        TeamWithProjectListModel teamWithProjectListModel = TeamWithProjectListModel(
          page: httpResponse.data.extraData?['page'],
          totalPages: httpResponse.data.extraData?['totalPages'],
          teamwithprojectlist: httpResponse.data.data!
          );
        return DataSuccess(teamWithProjectListModel);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusCode,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }

  }

  @override
  Future<DataState<ResponseMessage>> scoringTeam(double score, String judgeid, String workid) async {
    final httpResponse = await _scoreApiService.ScoringTeam(
      {
        "score" : double.parse(score.toStringAsFixed(2)),
        "judgeId" : judgeid,
        "workId" : workid
      }
    );

    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        return DataSuccess(httpResponse.data);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusCode,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }
}