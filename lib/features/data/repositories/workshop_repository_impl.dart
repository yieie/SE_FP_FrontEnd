import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/workshop_api_service.dart';
import 'package:front_end/features/data/models/workshop.dart';
import 'package:front_end/features/domain/repositories/workshop_repository.dart';

class WorkshopRepositoryImpl extends WorkshopRepository{
  final WorkshopApiService _workshopApiService;

  WorkshopRepositoryImpl(this._workshopApiService);

  @override
  Future<DataState<List<WorkshopModel>>> getWorkshop() async {
    final httpResponse = await _workshopApiService.getWorkshop();
    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        return DataSuccess(httpResponse.data.data!);
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
  Future<DataState<List<int>>> getWorkshopParticipation(String uid) async {
    final httpResponse = await  _workshopApiService.getWorkshopParticipation(uid: uid);

    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        return DataSuccess((httpResponse.data.extraData?['workshopId'] as List).cast<int>());
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
  Future<DataState<ResponseMessage>> joinWorkshop(String uid, int wsid) async {
    final httpResponse = await  _workshopApiService.joinWorkshop({"uId": uid, "workshopId": wsid});

    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
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