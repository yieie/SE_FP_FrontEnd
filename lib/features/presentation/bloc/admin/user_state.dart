import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/UserList.dart';
import 'package:front_end/features/domain/entity/identity/User.dart';

abstract class UserState {}

class UserInitial extends UserState{}

class UserLoading extends UserState{}

class UserListLoaded extends UserState{
  UserList userList;

  UserListLoaded(this.userList);
}

class UserDetailLoaded extends UserState{
  User user;

  UserDetailLoaded(this.user);
}

class UserError extends UserState{
  DioException error;

  UserError(this.error);
}


