import 'package:front_end/features/domain/entity/identity/Attendee.dart';
import 'package:front_end/features/domain/entity/identity/Teacher.dart';

class Team {
  final String ? teamID;
  final String ? name;
  final String ? type;
  final int ? rank;
  final Teacher ? teacher;
  final List<Attendee> ? members;

  const Team({
    this.teamID,
    this.name,
    this.type,
    this.rank,
    this.teacher,
    this.members
  });

  Team copyWith({
    String ? teamID,
    String ? name,
    String ? type,
    int ? rank,
    Teacher ? teacher,
    List<Attendee> ? members
  }) {
    return Team(
      teamID: teamID ?? this.teamID,
      name:name ?? this.name,
      type:type ?? this.type,
      rank:rank ?? this.rank,
      teacher:teacher ?? this.teacher,
      members:members ?? this.members
    );
  }
}