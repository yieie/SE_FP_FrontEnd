import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/entity/AnnouncementList.dart';

abstract class AnnRepository {
  
  Future<DataState<AnnouncementList>> get10announcement(int page);

  Future<DataState<Announcement>> getdetailannouncement(int aid);
}