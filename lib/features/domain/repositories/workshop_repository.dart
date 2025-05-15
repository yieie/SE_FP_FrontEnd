import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/Workshop.dart';

abstract class WorkshopRepository {
  Future<DataState<List<Workshop>>> getWorkshop();

  // Future<DataState<ResponseMessage>> registerforWorkshop(String wsid, String uid);
}