

import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/features/data/models/competitionForm.dart';
import 'package:front_end/features/data/models/team_with_project.dart';
import 'package:retrofit/retrofit.dart';

part 'competition_api_service.g.dart';


@RestApi(baseUrl: APIBaseURL)
abstract class CompetitionApiService {
  factory CompetitionApiService(Dio dio) = _CompetitionApiService;

  @POST('/competition/signUp.php')
  Future<HttpResponse<ResponseMessage>> signUpCompetition(@Body() CompetitionFormModel body);

  @POST('/upload/studentCard.php')
  Future<HttpResponse<ResponseMessage>> uploadStudentIDCard(@Body() FormData formData,);

  @POST('/upload/uploadWorkFile.php')
  Future<HttpResponse<ResponseMessage>> uploadFiles(@Body() FormData formData);

  // @POST('')
  // Future<HttpResponse<ResponseMessage>> editCompetitionInfo(@Body() Map<String, dynamic> body);

  
  @GET('/competition/getSignUpInfo.php')
  Future<HttpResponse<ResponseMessage>> getCompetitionInfoByUID(@Query("uId") String uid);

  @GET('/competition/getSignUpInfo.php')
  Future<HttpResponse<ResponseMessage>> getCompetitionInfoByTeamID(@Query('teamId') String teamid);

  @POST('/work/getPrevWorkList.php')
  Future<HttpResponse<ResponseMessage<TeamWithProjectModel>>> getPastProjectList(@Body() Map<String, dynamic> body);

  @GET('/teacher/teacherMainPage.php')
  Future<HttpResponse<ResponseMessage<TeamWithProjectModel>>> getTeachTeam(@Query('page') int page,@Query('teacherId') String teacherId);

}