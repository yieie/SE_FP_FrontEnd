import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';

abstract class AnnRepository {
  
  Future<DataState<List<Announcement>>> get10announcement(int page);

  Future<DataState<Announcement>> getdetailannouncement(int aid);
}