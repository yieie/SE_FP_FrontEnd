import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/ann_api_service.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';
import 'package:front_end/mock/ann_mock_api_response.dart';

class AnnRepositoryImpl implements AnnRepository{
  final AnnApiService _annApiService;

  AnnRepositoryImpl(this._annApiService);
  
  @override
  Future<DataState<List<AnnouncementModel>>> get10announcement(int page) async {
    final httpResponse = await _annApiService.get10announcement(page: page);
    try{
      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
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
  
  @override
  Future<DataState<Announcement>> getdetailannouncement(int aid)  async {
    final httpResponse = await _annApiService.getdetailannouncement(aid: aid);
    try{
      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
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