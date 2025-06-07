abstract class ScoreListEvent {
  const ScoreListEvent();
}

class GetScoreList extends ScoreListEvent {
  final int getpage;
  const GetScoreList(this.getpage);
}

class ScoringTeam extends ScoreListEvent {
  final double score;
  final String judgeid;
  final String workid;
  const ScoringTeam(this.score, this.judgeid,this.workid);
}


// class GetDetail extends ScoreListEvent {
//   final int getteamid;
//   const GetDetailAnnouncement(this.getteamid);
// }