
import 'package:front_end/features/domain/entity/SignInReqParams.dart';

abstract class SignInEvent {}

class SubminSignIn extends SignInEvent{
  final SignInReqParams signinReq;

  SubminSignIn(this.signinReq);
}