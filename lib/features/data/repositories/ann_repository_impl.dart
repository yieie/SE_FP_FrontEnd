import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/ann_api_service.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/data/models/announcementList.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';

class AnnRepositoryImpl implements AnnRepository{
  final AnnApiService _annApiService;

  AnnRepositoryImpl(this._annApiService);
  
  //一次拿10筆公告
  @override
  Future<DataState<AnnouncementListModel>> get10announcement(int page) async {
    final httpResponse = await _annApiService.get10announcement(page: page);

    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        AnnouncementListModel announcementListModel = AnnouncementListModel(
          page: httpResponse.data.extraData?['page'],
          totalPages: httpResponse.data.extraData?['totalPages'],
          announcements: httpResponse.data.data!
        );
        return DataSuccess(announcementListModel);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusCode,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }
  
  //拿取單筆公告詳細資料
  @override
  Future<DataState<AnnouncementModel>> getdetailannouncement(int aid)  async {
    final httpResponse = await _annApiService.getdetailannouncement(aid: aid);
    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        return DataSuccess(httpResponse.data.data![0]);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusCode,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }
}