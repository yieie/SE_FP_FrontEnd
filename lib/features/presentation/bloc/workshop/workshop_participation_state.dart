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