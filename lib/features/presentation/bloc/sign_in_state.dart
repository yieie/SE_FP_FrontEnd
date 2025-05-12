import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:front_end/features/domain/entity/ResponseMessage.dart';
import 'package:front_end/features/domain/entity/SignInReqParams.dart';

class SignInState extends Equatable{
  final SignInReqParams? signinReq;
  final ResponseMessage ? responseMessage;
  final DioException ? error;

  const SignInState({this.signinReq, this.responseMessage, this.error});

  @override
  List<Object?> get props => [signinReq, error];
}

class SignInInitial extends SignInState{
  const SignInInitial();
}

class SignInLoading extends SignInState{
  const SignInLoading();
}

class SignInSuccess extends SignInState{
  const SignInSuccess(ResponseMessage responseMessage) : super(responseMessage: responseMessage);
}

//有連到後端但登入不成功
class SignInFail extends SignInState{
  const SignInFail(ResponseMessage responseMessage) : super(responseMessage: responseMessage);
}

//其他錯誤 eg.連不到後端
class SignInError extends SignInState{
  const SignInError(DioException error) : super(error: error);
}