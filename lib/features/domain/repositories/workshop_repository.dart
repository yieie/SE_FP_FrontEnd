import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/Workshop.dart';

abstract class WorkshopRepository {
  Future<DataState<List<Workshop>>> getWorkshop();

  Future<DataState<List<int>>> getWorkshopParticipation(String uid);

  Future<DataState<ResponseMessage>> joinWorkshop(String uid, String wsid);
}