abstract class GetCompetitionInfoEvent {}

class GetInfoByUIDEvent extends GetCompetitionInfoEvent{
  String uid;

  GetInfoByUIDEvent(this.uid);
}