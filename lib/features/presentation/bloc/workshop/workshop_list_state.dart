import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/Workshop.dart';

abstract class WorkshopState {}

class WorkshopListInitial extends WorkshopState{}

class WorkshopListDone extends WorkshopState{
  final List<Workshop> workshop;
  WorkshopListDone({required this.workshop});
}

class WorkshopListError extends WorkshopState{
  final DioException error;
  WorkshopListError({required this.error});
}