import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:retrofit/retrofit.dart';

part 'admin_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class AdminApiService {
  factory AdminApiService(Dio dio) = _AdminApiService;

  @GET('/admin/getAdminMainPage.php')
  Future<HttpResponse<ResponseMessage>> getOverview();

  @POST('/ann/addAnn.php')
  Future<HttpResponse<ResponseMessage>> addNewAnnouncement(@Body() Map<String,dynamic> body);
}