import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/competition_api_service.dart';
import 'package:front_end/features/data/models/competitionForm.dart';
import 'package:front_end/features/domain/entity/CompetitionForm.dart';
import 'package:front_end/features/domain/repositories/competition_repository.dart';

class CompetitionRepositoryImpl implements CompetitionRepository {
  final CompetitionApiService _competitionApiService;

  CompetitionRepositoryImpl(this._competitionApiService);

  @override
  Future<DataState<ResponseMessage>> signUpCompetition(CompetitionForm data) async {
     try{
      final CompetitionFormModel req = CompetitionFormModel.fromEntity(data);
      final httpResponse = await _competitionApiService.signUpCompetition(req);

      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
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

  @override
  Future<DataState<ResponseMessage>> uploadFiles(String workid, PlatformFile consent, PlatformFile introduction, PlatformFile affidavit) async {
    try{
      final formData = FormData.fromMap({
        // 每个文件有不同的字段名
        'consent': MultipartFile.fromBytes(
          consent.bytes!,
          filename: consent.name,
        ),
        'introduction': MultipartFile.fromBytes(
          introduction.bytes!,
          filename: introduction.name,
        ),
        'affidavit': MultipartFile.fromBytes(
          affidavit.bytes!,
          filename: affidavit.name,
        ),
        'wordId': workid,
      });
      final httpResponse = await _competitionApiService.uploadFiles(formData);

      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        
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

  @override
  Future<DataState<ResponseMessage>> uploadStudentIDCard(String uid, PlatformFile file) async {
    try{
      final formData = FormData.fromMap({
        // 每个文件有不同的字段名
        'file': MultipartFile.fromBytes(
          file.bytes!,
          filename: file.name,
        ),
        'uId': uid,
      });
      final httpResponse = await _competitionApiService.uploadStudentIDCard(formData);

      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        
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