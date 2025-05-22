import 'package:dio/dio.dart';

abstract class WorkshopParticipationState {}

class ParticipationInitial extends WorkshopParticipationState{}

class ParticipationLoaded extends WorkshopParticipationState{
  List<int> participation;
  ParticipationLoaded({required this.participation});
}

class ParticipationError extends WorkshopParticipationState{
  DioException error;
  ParticipationError({required this.error});
}

class JoinSubmitting extends WorkshopParticipationState{
  String uid;
  int wsid;
  JoinSubmitting({required this.uid, required this.wsid});
}

class JoinSuccess extends WorkshopParticipationState{}

class JoinError extends WorkshopParticipationState{
  DioException error;
  JoinError({required this.error});
}