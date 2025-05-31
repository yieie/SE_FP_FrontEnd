

import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/features/data/models/competitionForm.dart';
import 'package:retrofit/retrofit.dart';

part 'competition_api_service.g.dart';

/* @POST('/upload')
Future<ResponseModel> uploadFile(
  @Body() FormData formData,
);
// 使用时：
final formData = FormData.fromMap({
  'file': await MultipartFile.fromFile(
    filePath,
    filename: 'upload.jpg',
    contentType: MediaType('image', 'jpeg'),
  ),
  'description': 'File description',
}); */

@RestApi(baseUrl: APIBaseURL)
abstract class CompetitionApiService {
  factory CompetitionApiService(Dio dio) = _CompetitionApiService;

  @POST('competition/signUp.php')
  Future<HttpResponse<ResponseMessage>> signUpCompetition(@Body() CompetitionFormModel body);

  @POST('/upload/studentCard.php')
  Future<HttpResponse<ResponseMessage>> uploadStudentIDCard(@Body() FormData formData,);

  @POST('/upload/uploadWorkFile.php')
  Future<HttpResponse<ResponseMessage>> uploadFiles(@Body() FormData formData);

  // @POST('')
  // Future<HttpResponse<ResponseMessage>> editCompetitionInfo(@Body() Map<String, dynamic> body);

  // @GET('')
  // Future<HttpResponse<ResponseMessage>> getCompetitionInfo(@Query("teamid") String teamid);

}