import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:front_end/features/data/models/sign_up_req_param.dart';

class SignUpState extends Equatable {
  final SignupReqParams signupReq;
  final DioException? error;

  const SignUpState({required this.signupReq, this.error});

  @override
  List<Object?> get props => [signupReq, error]; // 記得加上 signupReq 和 error
}

class SignUpInitial extends SignUpState {
  // const SignUpInitial() : super(signupReq: SignupReqParams());
  SignUpInitial(SignupReqParams signupReq) : super(signupReq: signupReq);
}

class SignUpLoading extends SignUpState {
  SignUpLoading(SignupReqParams signupReq) : super(signupReq: signupReq);
}

class SignUpSuccess extends SignUpState {
  SignUpSuccess(SignupReqParams signupReq) : super(signupReq: signupReq);
}

class SignUpFailure extends SignUpState {
  const SignUpFailure(DioException error, SignupReqParams signupReq)
      : super(signupReq: signupReq, error: error);
}
