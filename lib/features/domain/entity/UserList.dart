import 'package:front_end/features/domain/entity/identity/User.dart';

class UserList{
  final int page;
  final int totalpage;
  List<User> userlist;

  UserList({required this.page,required this.totalpage,required this.userlist});
}