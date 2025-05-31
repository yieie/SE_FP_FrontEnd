import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:retrofit/retrofit.dart';

part 'user_management_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class UserManagementApiService {
  factory UserManagementApiService(Dio dio) = _UserManagementApiService;

  @GET('/profile/getUserInfo.php')
  Future<HttpResponse<ResponseMessage>> searchUserbyUID(@Query("uId") String uid);
}