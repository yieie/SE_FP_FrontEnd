import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/features/data/models/workshop.dart';
import 'package:retrofit/retrofit.dart';

part 'workshop_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class WorkshopApiService {
  factory WorkshopApiService(Dio dio) = _WorkshopApiService;

  @POST('/workshop/getWorkshopList.php')
  Future<HttpResponse<ResponseMessage<WorkshopModel>>> getWorkshop();

  @GET('/workshop/getAttendedWorkshop.php')
  Future<HttpResponse<ResponseMessage>> getWorkshopParticipation({
    @Query("uId") String? uid,
  });

  @POST('/workshop/signUp.php')
  Future<HttpResponse<ResponseMessage>> joinWorkshop(@Body() Map<String, dynamic> body);
}