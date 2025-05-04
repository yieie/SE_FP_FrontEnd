
import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:retrofit/retrofit.dart';

part 'ann_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class AnnApiService {
  factory AnnApiService(Dio dio) = _AnnApiService;

  @GET('/ann/getAnnList.php')
  Future<HttpResponse<List<AnnouncementModel>>> get10announcement({
    @Query("page") int ? page
  });

  @GET('/ann/getAnnDetails.php')
  Future<HttpResponse<AnnouncementModel>> getdetailannouncement({
    @Query("aid") int ? aid
  });
}