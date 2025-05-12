import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/Workshop.dart';
import 'package:front_end/features/domain/repositories/workshop_repository.dart';

class GetWorkshop implements UseCase<DataState<List<Workshop>>, void>{
  final WorkshopRepository _workshopRepository;

  GetWorkshop(this._workshopRepository);
  
  @override
  Future<DataState<List<Workshop>>> call({void params}) {
    return _workshopRepository.getWorkshop();
  }

  
}