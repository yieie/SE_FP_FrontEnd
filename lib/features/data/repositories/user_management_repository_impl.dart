import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/user_management_api_service.dart';
import 'package:front_end/features/data/models/identity/admin.dart';
import 'package:front_end/features/data/models/identity/judge.dart';
import 'package:front_end/features/data/models/identity/lecturer.dart';
import 'package:front_end/features/data/models/identity/student.dart';
import 'package:front_end/features/data/models/identity/teacher.dart';
import 'package:front_end/features/data/models/identity/user_model_factory.dart';
import 'package:front_end/features/domain/entity/identity/Admin.dart';
import 'package:front_end/features/domain/entity/identity/Judge.dart';
import 'package:front_end/features/domain/entity/identity/Lecturer.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';
import 'package:front_end/features/domain/entity/identity/Teacher.dart';
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
            requestOptions: httpResponse.response.requestOptions,
            message: httpResponse.data.errorMessage
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }
  
  @override
  Future<DataState<ResponseMessage>> editProfile(User user) async {
    final model;
    if(user is Student){
      model = StudentModel.fromEntity(user).toJson();
    }
    else if(user is Judge){
      model = JudgeModel.fromEntity(user).toJson();
    }
    else if(user is Teacher){
      model = TeacherModel.fromEntity(user).toJson();
    }
    else if(user is Lecturer){
      model = LecturerModel.fromEntity(user).toJson();
    }
    else if(user is Admin){
      model = AdminModel.fromEntity(user).toJson();
    }else{
      model = null;
    }

    try{
      final httpResponse = await _userManagementApiService.editProfile(model);

      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        return DataSuccess(httpResponse.data);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
            message: httpResponse.data.errorMessage
          )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

}