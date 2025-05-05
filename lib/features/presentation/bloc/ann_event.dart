abstract class AnnEvent {
  const AnnEvent();
}

class Get10Announcement extends AnnEvent {
  final int getpage;
  const Get10Announcement(this.getpage);
}

class GetDetailAnnouncement extends AnnEvent {
  final int getaid;
  const GetDetailAnnouncement(this.getaid);
}