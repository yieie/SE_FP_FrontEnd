abstract class WorkshopParticipationEvent {}

class GetWorkshopParticipation extends WorkshopParticipationEvent{
  final String uid;
  GetWorkshopParticipation({required this.uid});
}

class JoinWorkshop extends WorkshopParticipationEvent{
  final String uid;
  final String wsid;
  JoinWorkshop({required this.uid, required this.wsid});
}