import 'package:equatable/equatable.dart';

class Announcement extends Equatable{
  final int ? aid;
  final String ? title;
  final String ? content;
  final String ? time;
  final String ? uid;
  final List<String> ? posterUrl;
  final List<({String fileName, String fileUrl})> ? file; 

  const Announcement({
    this.aid,
    this.title,
    this.content,
    this.time,
    this.uid,
    this.posterUrl,
    this.file
  });

  @override
  List < Object ? > get props {
    return [
      aid,
      title,
      content,
      time,
      uid,
      posterUrl,
      file
    ];
  }
}