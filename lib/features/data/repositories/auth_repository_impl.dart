
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/auth_api_service.dart';
import 'package:front_end/features/data/models/sign_in_req_param.dart';
import 'package:front_end/features/data/models/sign_up_req_param.dart';
import 'package:front_end/features/domain/entity/SignInReqParams.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';
import 'package:front_end/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);


  //註冊
  @override
  Future<DataState<ResponseMessage>> signUp(Student student, String password) async {
    final signupReq = SignupReqParams(
      uid: student.uid,
      password: password,
      name: student.name, 
      email: student.email,
      sexual: student.sexual,
      phone: student.phone,
      department: student.department,
      grade: student.grade
    );
    try{
      final httpResponse = await _authApiService.signUp(signupReq);

      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
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


  //登入
  @override
  Future<DataState<ResponseMessage>> signIn(SignInReqParams signinReq) async {
    try{
      final httpResponse= await _authApiService.signIn(SignInReqParamModel.fromEntity(signinReq));

      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
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