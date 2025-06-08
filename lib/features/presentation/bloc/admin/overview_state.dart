import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/Admin_Overview.dart';

abstract class OverviewState {}

class OverviewInitial extends OverviewState {}

class OverviewLoading extends OverviewState {}

class OverviewLoaded extends OverviewState {
  final AdminOverview adminOverview;

  OverviewLoaded(this.adminOverview);
}

class OverviewError extends OverviewState {
  DioException error;

  OverviewError(this.error);
}