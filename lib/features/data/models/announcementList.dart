import 'package:front_end/features/data/models/announcement.dart';
import 'package:front_end/features/domain/entity/AnnouncementList.dart';

class AnnouncementListModel extends AnnouncementList{
  AnnouncementListModel({
    required int page,
    required int totalPages,
    required List<AnnouncementModel> announcements
  }):super(page: page, totalPages: totalPages, announcements: announcements);
}