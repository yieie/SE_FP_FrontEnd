import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/identity/User.dart';

abstract class UserManagementRepository {
  Future<DataState<User>> searchUserbyUID(String uid);

  Future<DataState<ResponseMessage>> editProfile(User user);
}