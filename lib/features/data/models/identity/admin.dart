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

  factory AdminModel.fromEntity(Admin admin){
    return AdminModel(
      uid: admin.uid,
      name: admin.name,
      email: admin.email,
      sexual: admin.sexual,
      phone: admin.phone,
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "uId": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "sexual": sexual,
    };
  }
}