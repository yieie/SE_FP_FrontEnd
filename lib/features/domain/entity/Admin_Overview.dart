class AdminOverview {
  final int totaluser;
  final int studentAmount;
  final int attendeeAmount;
  final int teacherAmount;
  final int lecturerAmount;
  final int judgeAmount;

  final int totalTeam;
  final int verified;
  final int needVerify;
  final int needReAttached;

  AdminOverview({
    required this.totaluser,
    required this.studentAmount,
    required this.attendeeAmount,
    required this.teacherAmount,
    required this.lecturerAmount,
    required this.judgeAmount,
    required this.totalTeam,
    required this.verified,
    required this.needVerify,
    required this.needReAttached
  });
}