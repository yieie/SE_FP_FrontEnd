import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/Admin_Overview.dart';
import 'package:front_end/features/domain/repositories/admin_repository.dart';

class GetOverviewUseCase implements UseCase<DataState<AdminOverview>,void>{
  final AdminRepository _adminRepository;

  GetOverviewUseCase(this._adminRepository);

  @override
  Future<DataState<AdminOverview>> call({void params}) {
    return _adminRepository.getOverview();
  }

}