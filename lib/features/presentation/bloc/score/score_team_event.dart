abstract class ScoreTeamEvent {}

class LoadTeamInfoEvent extends ScoreTeamEvent{
  final String teamid;

  LoadTeamInfoEvent({required this.teamid});
}

class SubmitScoreEvent extends ScoreTeamEvent{
  final double score;
  final String workid;
  final String judgeid;

  SubmitScoreEvent({required this.score,required this.workid,required this.judgeid});
}