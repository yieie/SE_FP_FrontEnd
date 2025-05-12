import 'package:front_end/features/domain/entity/SignInReqParams.dart';

class SignInReqParamModel extends SignInReqParams{
  SignInReqParamModel({required super.account, required super.password});


  factory SignInReqParamModel.fromJson(Map<String, dynamic> json){
    return SignInReqParamModel(
      account : json['id'] as String,
      password : json['password'] as String
    );
  }

  factory SignInReqParamModel.fromEntity(SignInReqParams signinReq){
    return SignInReqParamModel(account: signinReq.account, password: signinReq.password);
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : account,
      'password': password 
    };
  }
}