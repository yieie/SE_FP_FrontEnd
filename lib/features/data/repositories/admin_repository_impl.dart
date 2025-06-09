import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/admin_api_service.dart';
import 'package:front_end/features/data/models/admin_overview.dart';
import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/entity/Admin_Overview.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';
import 'package:front_end/features/domain/repositories/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository{
  final AdminApiService _adminApiService;

  AdminRepositoryImpl(this._adminApiService);

  
  @override
  Future<DataState<AdminOverview>> getOverview() async {
    final httpResponse = await _adminApiService.getOverview();
    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        final overview = AdminOverviewModel.fromJson(httpResponse.data.extraData!);
        return DataSuccess(overview);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusCode,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
            message: httpResponse.data.errorMessage
          )
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TeamWithProjectList>> getVertifyTeam(int page, int year) async {
    final httpResponse = await _adminApiService.getVertifyTeam(page,year);
    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        TeamWithProjectList list = TeamWithProjectList(
          page: httpResponse.data.extraData!['page'], 
          totalPages: httpResponse.data.extraData!['totalPage'], 
          teamwithprojectlist: httpResponse.data.data!
        );
        return DataSuccess(list);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusCode,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
            message: httpResponse.data.errorMessage
          )
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }
  
  @override
  Future<DataState<ResponseMessage>> updateTeamState(String teamid, String state,String? message) async {
    final httpResponse = await _adminApiService.updateTeamState({'teamId':teamid, 'state':state,'message': message});
    try{
      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        return DataSuccess(httpResponse.data);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusCode,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
            message: httpResponse.data.errorMessage
          )
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }

 
}