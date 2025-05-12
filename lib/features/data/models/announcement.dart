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
  }): super(//有改
    aid: aid,
    title: title,
    content: content,
    time: time,
    uid: uid,
    posterUrl: posterUrl,
    file: file
  );

  factory AnnouncementModel.fromJson(Map < String, dynamic> map){
    return AnnouncementModel(
      //aid:  map['aid'] ?? "",
      aid: map['aid'] != null ? int.tryParse(map['aid'].toString()) : null,//有改

      title: map['title'] ?? "",
      content: map['content'] ?? "",
      time: map['time'] ?? "",
      uid: map['uid'] ?? "",

      //posterUrl: map['posterUrls'] ?? ""
      posterUrl: map['posterUrls'] != null
        ? List<String>.from(map['posterUrls'])
        : []//有改

      //file: map['']
    );

  }
}