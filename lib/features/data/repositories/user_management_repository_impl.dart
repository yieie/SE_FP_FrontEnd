import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/user_management_api_service.dart';
import 'package:front_end/features/data/models/identity/user_model_factory.dart';
import 'package:front_end/features/domain/entity/identity/User.dart';
import 'package:front_end/features/domain/repositories/user_management_repository.dart';

class UserManagementRepositoryimpl implements UserManagementRepository {
  final UserManagementApiService _userManagementApiService;

  UserManagementRepositoryimpl(this._userManagementApiService);
  
  @override
  Future<DataState<User>> searchUserbyUID(String uid) async {
    try{
      final httpResponse = await _userManagementApiService.searchUserbyUID(uid);

      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        User user = UserModelFactory.fromJson(httpResponse.data.extraData!);
        return DataSuccess(user);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

}