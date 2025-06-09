import 'package:front_end/features/domain/entity/identity/User.dart';

class UserModel extends User{
  UserModel({
    super.name,
    super.email,
    super.uid,
    super.phone,
    super.sexual
  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      uid: json['uId'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sexual: json['sexual'] as String?,
      phone: json['phone'] as String?,
    );
  }

  factory UserModel.fromEntity(User admin){
    return UserModel(
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