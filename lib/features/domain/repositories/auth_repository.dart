

import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/data/models/sign_up_req_param.dart';

abstract class AuthRepository {
  Future<DataState<SignupReqParams>> signUp(SignupReqParams signupReq);
}