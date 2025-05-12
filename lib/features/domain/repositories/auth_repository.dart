

import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/ResponseMessage.dart';
import 'package:front_end/features/domain/entity/SignInReqParams.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';

abstract class AuthRepository {
  Future<DataState<ResponseMessage>> signUp(Student student, String password);

  Future<DataState<ResponseMessage>> signIn(SignInReqParams signInReq);
}