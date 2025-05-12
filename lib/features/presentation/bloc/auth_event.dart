abstract class AuthEvent {}

class AppStarted extends AuthEvent{}

class LoggedIn extends AuthEvent{
  final String usertype;
  final String uid;

  LoggedIn({required this.usertype, required this.uid});
}

class LoggedOut extends AuthEvent{}
