import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/features/data/models/response_message.dart';
import 'package:front_end/features/data/models/sign_in_req_param.dart';
import 'package:front_end/features/data/models/sign_up_req_param.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('/auth/register.php')
  Future<HttpResponse<ResponseMessageModel>> signUp (@Body() SignupReqParams signupReq);

  @POST('/auth/login.php')
  Future<HttpResponse<ResponseMessageModel>> signIn(@Body() SignInReqParamModel signinReq);
}