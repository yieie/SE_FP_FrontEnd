import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/identity/User.dart';

abstract class SearchUserState {}

class SearchInitial extends SearchUserState {}

class SearchDone extends SearchUserState{
  final User user;

  SearchDone({required this.user});
}

class SearchError extends SearchUserState{
  final DioException error;

  SearchError({required this.error});
}