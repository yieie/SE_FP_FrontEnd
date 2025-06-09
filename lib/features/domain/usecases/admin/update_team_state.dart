import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/repositories/admin_repository.dart';

class UpdateTeamStateUseCase implements UseCase<DataState<ResponseMessage>,void>{
  final AdminRepository _adminRepository;

  UpdateTeamStateUseCase(this._adminRepository);
  
  @override
  Future<DataState<ResponseMessage>> call({void params,String? teamid,String? state , String? message}) {
    return _adminRepository.updateTeamState(teamid!, state!, message);
  }

  
}