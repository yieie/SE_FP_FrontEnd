import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/features/data/models/team_with_project.dart';
import 'package:front_end/features/data/models/team_with_project_list.dart';
import 'package:retrofit/retrofit.dart';

part 'admin_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class AdminApiService {
  factory AdminApiService(Dio dio) = _AdminApiService;

  @GET('/admin/getAdminMainPage.php')
  Future<HttpResponse<ResponseMessage>> getOverview();

  @GET('/admin/regApprovalMainPage.php')
  Future<HttpResponse<ResponseMessage<TeamWithProjectModel>>> getVertifyTeam(@Query('page') int page, @Query('year') int year);

  @PUT('/admin/updateTeamState.php')
  Future<HttpResponse<ResponseMessage>> updateTeamState(@Body() Map<String, dynamic> body);

  @GET('/admin/getScoreInfo.php')
  Future<HttpResponse<ResponseMessage<TeamWithProjectModel>>> getScoreResults(@Query('page') int page, @Query('year') String year,@Query('teamType') String teamType);
}