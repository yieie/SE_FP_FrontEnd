import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/repositories/workshop_repository.dart';

class JoinWorkshopUseCase implements UseCase<DataState<ResponseMessage>, List<String>>{
  final WorkshopRepository _workshopRepository;

  JoinWorkshopUseCase(this._workshopRepository);
  
  @override
  Future<DataState<ResponseMessage>> call({List<String>? params}) {
    return _workshopRepository.joinWorkshop(params![0], params[1]);
  }

}