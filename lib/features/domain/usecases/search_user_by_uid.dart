import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/identity/User.dart';
import 'package:front_end/features/domain/repositories/user_management_repository.dart';

class SearchUserByUidUseCase implements UseCase<DataState<User>, String>{
  final UserManagementRepository _userManagementRepository;

  SearchUserByUidUseCase(this._userManagementRepository);
  
  @override
  Future<DataState<User>> call({String params=""}) async { 
    return _userManagementRepository.searchUserbyUID(params);
  }
  
 

}