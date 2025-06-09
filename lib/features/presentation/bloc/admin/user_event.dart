abstract class UserEvent {}

class GetUserListEvent extends UserEvent{
  final int page;
  final String usertype;

  GetUserListEvent(this.page,this.usertype);
}

class GetUserDetailEvent extends UserEvent {
  final String uid;

  GetUserDetailEvent(this.uid);
}