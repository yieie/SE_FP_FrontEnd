import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/repositories/workshop_repository.dart';

class GetWorkshopParticipationUseCase implements UseCase<DataState<List<int>>, String>{
  final WorkshopRepository _workshopRepository;

  GetWorkshopParticipationUseCase(this._workshopRepository);
  
  @override
  Future<DataState<List<int>>> call({String? params}) {
    return _workshopRepository.getWorkshopParticipation(params!);
  }

}