abstract class TeachTeamEvent {}

class GetTeachTeamListEvent extends TeachTeamEvent{
  final int page;
  final String teacherid;

  GetTeachTeamListEvent(this.page,this.teacherid);
}

class GetTeachTeamDetailEvent extends TeachTeamEvent{
  final String teamid;

  GetTeachTeamDetailEvent(this.teamid);
}