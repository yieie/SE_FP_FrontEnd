import 'package:front_end/features/domain/entity/identity/User.dart';

abstract class ProfileManageEvent {}

class SearchUserbyUID extends ProfileManageEvent {
  final String uid;
  
  SearchUserbyUID({required this.uid});
}

class EditProfileEvent extends ProfileManageEvent {
  final User original;
  final String name;
  final String sexual;
  final String phone;
  final String email;
  final String ? department;
  final String ? grade;
  final String ? organization;
  final String ? title;

  EditProfileEvent({required this.original, required this.name,required this.sexual,
  required this.phone,required this.email,this.department,this.grade,this.organization,this.title});
}