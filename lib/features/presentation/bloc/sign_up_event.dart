import 'package:front_end/features/data/models/sign_up_req_param.dart';

abstract class SignUpEvent {}

class SubmitSignUp extends SignUpEvent{
  final SignupReqParams signupReq;

  SubmitSignUp(this.signupReq);
}


class SexualChanged extends SignUpEvent {
  final String sexual;
  SexualChanged(this.sexual);
}

class DepartmentChanged extends SignUpEvent {
  final String department;
  DepartmentChanged(this.department);
}

class GradeChanged extends SignUpEvent {
  final String grade;
  GradeChanged(this.grade);
}
