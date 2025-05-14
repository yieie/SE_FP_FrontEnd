
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/auth_api_service.dart';
import 'package:front_end/features/data/models/sign_up_req_param.dart';
import 'package:front_end/features/domain/entity/Student.dart';
import 'package:front_end/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<SignupReqParams>> signUp(Student student, String password) async {
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
}