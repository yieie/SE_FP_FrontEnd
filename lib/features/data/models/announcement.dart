import 'package:front_end/features/domain/entity/Announcement.dart';

class AnnouncementModel extends Announcement{
  const AnnouncementModel({
    int ? aid,
    String ? title,
    String ? content,
    String ? time,
    String ?uid,
    List<String> ? posterUrl,
    List<({String fileName, String fileUrl})> ? file
  });

  factory AnnouncementModel.fromJson(Map < String, dynamic> map){
    return AnnouncementModel(
      aid:  map['aid'] ?? "",
      title: map['title'] ?? "",
      content: map['content'] ?? "",
      time: map['time'] ?? "",
      uid: map['uid'] ?? "",
      posterUrl: map['posterUrls'] ?? ""
      //file: map['']
    );

  }
}