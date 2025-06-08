import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/entity/Admin_Overview.dart';

abstract class AdminRepository {
  Future<DataState<AdminOverview>> getOverview();

  Future<DataState<ResponseMessage>> addNewAnnouncement(Announcement ann,String adminid);
}