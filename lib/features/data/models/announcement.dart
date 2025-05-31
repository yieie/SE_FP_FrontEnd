import 'package:front_end/features/domain/entity/Announcement.dart';

class AnnouncementModel extends Announcement{
  const AnnouncementModel({
    int ? aid,
    String ? title,
    String ? content,
    String ? time,
    String ? uid,
    List<String> ? posterUrl,
    List<({String fileName, String fileUrl})> ? file
  }): super(
    aid: aid,
    title: title,
    content: content,
    time: time,
    uid: uid,
    posterUrl: posterUrl,
    file: file
  );

  factory AnnouncementModel.fromJson(Map<String, dynamic> json){
    return AnnouncementModel(
      aid: json['aId'],
      title: json['title'] ?? "",
      content: json['content'] ?? "",
      time: json['time'] ?? "",
      posterUrl: json['posterUrls'] != null
        ? List<String>.from(json['posterUrls'])
        : [],

      file: json['files'] != null 
        ? (json['files'] as List).map<({String fileName, String fileUrl})>((item){
          return (
            fileName: item['name'] as String? ?? "",
            fileUrl: item['url'] as String? ?? ""
          );
        }).toList()
        :[]
    );

  }
}