import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/UserList.dart';
import 'package:front_end/features/domain/repositories/admin_repository.dart';

class GetUserListUseCase implements UseCase<DataState<UserList>,void>{
  final AdminRepository _adminRepository;

  GetUserListUseCase(this._adminRepository);
  
  @override
  Future<DataState<UserList>> call({void params, int? page,String? usertype}) {
    return _adminRepository.getUserList(page!, usertype!);
  }

  
}