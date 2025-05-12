import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/features/data/models/response_message.dart';
import 'package:front_end/features/data/models/sign_in_req_param.dart';
import 'package:front_end/features/data/models/sign_up_req_param.dart';
import 'package:front_end/features/data/models/workshop.dart';
import 'package:retrofit/retrofit.dart';

part 'workshop_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class WorkshopApiService {
  factory WorkshopApiService(Dio dio) = _WorkshopApiService;

  //路徑需確認API文件
  @POST('')
  Future<HttpResponse<List<WorkshopModel>>> getWorkshop();

}