import 'package:equatable/equatable.dart';

class Team extends Equatable{
  final String ? teamID;
  final String ? name;
  final String ? type;
  final String ? leader;
  final String ? rank;
  final String ? teacher;

  const Team({
    this.teamID,
    this.name,
    this.type,
    this.leader,
    this.rank,
    this.teacher
  });
  
  @override
  List<Object?> get props {
    return [teamID, name, type, leader, rank, teacher];
  }
}