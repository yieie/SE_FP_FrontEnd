abstract class PastProjectEvent {}

class GetPastProjectbyYearAndTeamtypeEvent extends PastProjectEvent{
  final String year;
  final String teamType;

  GetPastProjectbyYearAndTeamtypeEvent({required this.year,required this.teamType});
}

class GetPastProjectDetailbyTeamIDEvent extends PastProjectEvent{
  final String teamid;

  GetPastProjectDetailbyTeamIDEvent({required this.teamid});
}