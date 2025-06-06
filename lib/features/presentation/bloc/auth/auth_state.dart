import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{
  final String? usertype;
  
  const AuthState({this.usertype});

  @override
  List<Object?> get props =>[usertype];
}

class AuthInitial extends AuthState{}

class Authenticated extends AuthState{
  final String uid;
  const Authenticated({required super.usertype, required this.uid});
}

class Unauthenticated extends AuthState{}