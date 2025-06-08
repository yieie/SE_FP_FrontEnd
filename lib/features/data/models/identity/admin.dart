import 'package:front_end/features/domain/entity/identity/Admin.dart';

class AdminModel extends Admin{
  AdminModel({
    super.name,
    super.email,
    super.uid,
    super.phone,
    super.sexual
  });

  factory AdminModel.fromJson(Map<String,dynamic> json){
    return AdminModel(
      uid: json['uId'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sexual: json['sexual'] as String?,
      phone: json['phone'] as String?,
    );
  }
}