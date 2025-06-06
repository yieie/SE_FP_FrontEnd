class Workshop {
  final int ? wsid;
  final String ? time;
  final String ? topic;
  final int ? amount; //可報名總人數
  final int ? registered; //已報名人數
  final String ? lecturerName;
  final String ? lecturerTitle;

  const Workshop({
    this.wsid,
    this.time,
    this.topic,
    this.amount,
    this.registered,
    this.lecturerName,
    this.lecturerTitle
  });
}