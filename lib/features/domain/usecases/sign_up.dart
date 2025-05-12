
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/ResponseMessage.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';
import 'package:front_end/features/domain/repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<DataState<ResponseMessage>,Student>{
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);
  
  @override
  Future<DataState<ResponseMessage>> call({Student? params, String? password}) {
    return _authRepository.signUp(params!, password!);
  }
}