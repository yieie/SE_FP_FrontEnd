import 'package:dio/dio.dart';

abstract class AnnModifyAddState {}

class AnnInitial extends AnnModifyAddState{}

class AnnOperateSubmitting extends AnnModifyAddState{}

class AnnOperateSuccess extends AnnModifyAddState{}

class AnnOperateFailure extends AnnModifyAddState{
  final DioException error;

  AnnOperateFailure(this.error);
}