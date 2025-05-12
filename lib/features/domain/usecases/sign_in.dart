import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/ResponseMessage.dart';
import 'package:front_end/features/domain/entity/SignInReqParams.dart';
import 'package:front_end/features/domain/repositories/auth_repository.dart';

class SignInUseCase extends UseCase<DataState<ResponseMessage>, SignInReqParams>{
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<DataState<ResponseMessage>> call({SignInReqParams ? params}) {
    return _authRepository.signIn(params!);
  }
}