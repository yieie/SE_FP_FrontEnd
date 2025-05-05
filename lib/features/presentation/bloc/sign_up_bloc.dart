import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/data/models/sign_up_req_param.dart';
import 'package:front_end/features/domain/usecases/sign_up.dart';
import 'package:front_end/features/presentation/bloc/sign_up_event.dart';
import 'package:front_end/features/presentation/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  final SignUpUseCase _signUpUseCase;

  SignUpBloc(this._signUpUseCase) : super(SignUpInitial(SignupReqParams())){

    on<SubmitSignUp>((event, emit) async{
      emit(SignUpLoading(event.signupReq));
      try{
        print('📦 Request Body: ${event.signupReq.toJson()}');
        await _signUpUseCase(params: event.signupReq, password: event.signupReq.password);
        emit(SignUpSuccess(event.signupReq));
      }on DioException catch(e){
        emit(SignUpFailure(e,event.signupReq));
      }
    });


    on<SexualChanged>((event, emit) async{
      final updated = state.signupReq.copyWith(sexual: event.sexual);
      emit(SignUpInitial(updated));
    });

    on<DepartmentChanged>((event, emit) async {
      final updated = state.signupReq.copyWith(department: event.department);
      emit(SignUpInitial(updated));
    });

    on<GradeChanged>((event, emit) async{
      final updated = state.signupReq.copyWith(grade: event.grade);
      emit(SignUpInitial(updated));
    });
  }
}