import 'package:front_end/features/domain/entity/ResponseMessage.dart';

class ResponseMessageModel extends ResponseMessage{
  ResponseMessageModel({
    required super.success,super.usertype, required super.message
  });

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json){
    return ResponseMessageModel(
      success: json['success'] as bool, 
      usertype: json['userType'] as String,
      message: json['error'] as String
    );
  }
}