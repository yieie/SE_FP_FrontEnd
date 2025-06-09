abstract class VertifyTeamEvent {}

class GetVertifyTeamListEvent extends VertifyTeamEvent{
  final int page;

  GetVertifyTeamListEvent(this.page);
}

class GetVertifyTeamDetailEvent extends VertifyTeamEvent{
  final String teamid;

  GetVertifyTeamDetailEvent(this.teamid);
}

class SubmitStateEvent extends VertifyTeamEvent{
  final String teamid;
  final String state;
  final String? message;
  
  SubmitStateEvent({required this.teamid, required this.state,this.message});
}