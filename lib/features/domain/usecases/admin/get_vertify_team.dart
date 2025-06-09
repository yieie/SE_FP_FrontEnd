import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';
import 'package:front_end/features/domain/repositories/admin_repository.dart';

class GetVertifyTeamUseCase implements UseCase<DataState<TeamWithProjectList>,void>{
  final AdminRepository _adminRepository;

  GetVertifyTeamUseCase(this._adminRepository);

  @override
  Future<DataState<TeamWithProjectList>> call({void params,int? page}) {
    int year = DateTime.now().year;
    return _adminRepository.getVertifyTeam(page!,year);
  }

}