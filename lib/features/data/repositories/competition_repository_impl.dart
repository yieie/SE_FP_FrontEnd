import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/datasources/remote/competition_api_service.dart';
import 'package:front_end/features/data/models/competitionForm.dart';
import 'package:front_end/features/data/models/team_with_project.dart';
import 'package:front_end/features/domain/entity/CompetitionForm.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';
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
  Future<DataState<ResponseMessage>> uploadFiles(String workid, PlatformFile? consent, PlatformFile? introduction, PlatformFile? affidavit) async {
    try{
      final formData = FormData.fromMap({
        // 每个文件有不同的字段名
        if(consent != null)
          'consent': MultipartFile.fromBytes(
            consent.bytes!,
            filename: consent.name,
          ),
        if(introduction !=null)
          'introduction': MultipartFile.fromBytes(
            introduction.bytes!,
            filename: introduction.name,
          ),
        if(affidavit != null)
          'affidavit': MultipartFile.fromBytes(
            affidavit.bytes!,
            filename: affidavit.name,
          ),
        'workId': workid,
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
  Future<DataState<TeamWithProjectModel>> getCompetitionInfoByUID(String uid) async {
    try{
      final httpResponse = await _competitionApiService.getCompetitionInfoByUID(uid);

      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        final teamwithproject = TeamWithProjectModel.fromJson(httpResponse.data.extraData!);
        return DataSuccess(teamwithproject);
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
  Future<DataState<TeamWithProject>> getCompetitionInfoByTeamID(String teamid) async {
    try{
      final httpResponse = await _competitionApiService.getCompetitionInfoByTeamID(teamid);

      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        final teamwithproject = TeamWithProjectModel.fromJson(httpResponse.data.extraData!);
        return DataSuccess(teamwithproject);
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
  Future<DataState<List<TeamWithProject>>> getPastProjectList(String year, String teamType) async {
    try{
      final httpResponse = await _competitionApiService.getPastProjectList({'year':year, 'teamType': teamType});

      if(httpResponse.response.statusCode == HttpStatus.ok && httpResponse.data.success){
        return DataSuccess(httpResponse.data.data!);
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
  Future<DataState<TeamWithProjectList>> getTeachTeam(int page, String teacherid) async {
    final httpResponse = await _competitionApiService.getTeachTeam(page, teacherid);
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
  Future<DataState<ResponseMessage>> deleteAffidavitFile(String workid) async {
    final httpResponse = await _competitionApiService.deleteAffidavitFile(workid);
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
  
  @override
  Future<DataState<ResponseMessage>> deleteConsentFile(String workid) async {
    final httpResponse = await _competitionApiService.deleteConsentFile(workid);
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
  
  @override
  Future<DataState<ResponseMessage>> deleteIntroductionFile(String workid) async {
    final httpResponse = await _competitionApiService.deleteIntroductionFile(workid);
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
  
  @override
  Future<DataState<ResponseMessage>> deleteStudentCard(String uid) async {
    final httpResponse = await _competitionApiService.deleteStudentCard(uid);
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
  
  @override
  Future<DataState<ResponseMessage>> editCompetitionInfo(String teamid,String workid,CompetitionForm data) async {
    final httpResponse = await _competitionApiService.editCompetitionInfo(
      {
        "teamId":teamid,
        "workId":workid,
        "workAbstract":data.abstract,
        "workUrls":data.url,
        "sdgs":data.sdgs
      });
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