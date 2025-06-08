
import 'package:dio/dio.dart';
import 'package:front_end/cores/constants/constants.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:retrofit/retrofit.dart';

part 'ann_api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class AnnApiService {
  factory AnnApiService(Dio dio) = _AnnApiService;

  @GET('/ann/getAnnList.php')
  Future<HttpResponse<ResponseMessage<AnnouncementModel>>> get10announcement({
    @Query("page") int ? page
  });

  @GET('/ann/getAnnDetails.php')
  Future<HttpResponse< ResponseMessage<AnnouncementModel>>> getdetailannouncement({
    @Query("aId") int ? aid
  });
  
  @POST('/ann/addAnn.php')
  Future<HttpResponse<ResponseMessage>> addNewAnnouncement(@Body() AnnouncementModel body);
  
  @POST('/upload/uploadAnnPoster.php')
  Future<HttpResponse<ResponseMessage>> uploadAnnouncementPoster(@Body() FormData formData);

  @POST('/upload/uploadAnnFile.php')
  Future<HttpResponse<ResponseMessage>> uploadAnnouncementFile(@Body() FormData formData);

  @POST('/ann/editAnn.php')
  Future<HttpResponse<ResponseMessage>> editAnnouncement(@Body() AnnouncementModel body);

  @DELETE('/ann/deleteAnnPoster.php')
  Future<HttpResponse<ResponseMessage>> deleteAnnouncementPoster(@Query('aId') int aid,@Query('posterUrl') String url);

  @DELETE('/ann/deleteAnnFile.php')
  Future<HttpResponse<ResponseMessage>> deleteAnnouncementFile(@Query('aId') int aid,@Query('fileName') String name, @Query('fileUrl') String url);
}