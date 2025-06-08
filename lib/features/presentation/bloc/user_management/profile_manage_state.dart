import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/identity/User.dart';

abstract class ProfileManageState {}

class ProfileInitial extends ProfileManageState {}

class ProfileLoaded extends ProfileManageState{
  final User user;

  ProfileLoaded({required this.user});
}


class ProfileEditting extends ProfileManageState{}

class ProfileSuccess extends ProfileManageState{}

class ProfileError extends ProfileManageState{
  final DioException error;

  ProfileError({required this.error});
}