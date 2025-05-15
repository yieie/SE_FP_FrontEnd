import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/workshop_api_service.dart';
import 'package:front_end/features/domain/entity/Workshop.dart';
import 'package:front_end/features/domain/repositories/workshop_repository.dart';

class WorkshopRepositoryImpl extends WorkshopRepository{
  final WorkshopApiService _workshopApiService;

  WorkshopRepositoryImpl(this._workshopApiService);

  @override
  Future<DataState<List<Workshop>>> getWorkshop() async {
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
  
  // @override
  // Future<DataState<ResponseMessage>> registerforWorkshop(String wsid, String uid) async {
  //   final httpResponse = await  _workshopApiService.registerforWorkshop();

  //   try{
  //     if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
  //       return DataSuccess(httpResponse.data);
  //     }else {
  //       return DataFailed(
  //         DioException(
  //           error: httpResponse.response.statusCode,
  //           response: httpResponse.response,
  //           type: DioExceptionType.badResponse,
  //           requestOptions: httpResponse.response.requestOptions
  //         )
  //       );
  //     }
  //   }on DioException catch(e){
  //     return DataFailed(e);
  //   }
  // }
}