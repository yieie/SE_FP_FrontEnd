

import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/identity/User.dart';
import 'package:front_end/features/domain/repositories/user_management_repository.dart';

class EditProfileUseCase implements UseCase<DataState<ResponseMessage>,void> {
  final UserManagementRepository _userManagementRepository;

  EditProfileUseCase(this._userManagementRepository);

  @override
  Future<DataState<ResponseMessage>> call({void params,User ? user}) {
    return _userManagementRepository.editProfile(user!);
  }

}