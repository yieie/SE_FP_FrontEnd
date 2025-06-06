

import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/features/data/models/competitionForm.dart';
import 'package:front_end/features/data/models/team_with_project.dart';
import 'package:front_end/features/data/models/team_with_project_list.dart';
import 'package:retrofit/retrofit.dart';

part 'score_api_service.g.dart';


@RestApi(baseUrl: APIBaseURL)
abstract class ScoreApiService {
  factory ScoreApiService(Dio dio) = _ScoreApiService;

  @GET('/judge/judgeMainPage.php')
  Future<HttpResponse<ResponseMessage<TeamWithProjectModel>>> getScoreList(@Query('page') int page);

  @POST('/judge/scoring.php')
  Future<HttpResponse<ResponseMessage>> ScoringTeam(@Body() Map<String, dynamic> data);

}