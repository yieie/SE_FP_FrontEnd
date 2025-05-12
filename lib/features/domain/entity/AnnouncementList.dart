import 'package:front_end/features/domain/entity/Announcement.dart';

class AnnouncementList {
  final int page;
  final int totalPages;
  final List<Announcement> announcements;

  AnnouncementList({required this.page, required this.totalPages, required this.announcements});
}