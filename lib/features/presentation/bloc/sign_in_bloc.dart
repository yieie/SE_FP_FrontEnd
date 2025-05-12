import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/sign_in.dart';
import 'package:front_end/features/presentation/bloc/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth_event.dart';
import 'package:front_end/features/presentation/bloc/sign_in_event.dart';
import 'package:front_end/features/presentation/bloc/sign_in_state.dart';
import 'package:front_end/injection_container.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  final SignInUseCase _signInUseCase;

  SignInBloc(this._signInUseCase) : super(SignInInitial()){
    on<SubminSignIn> (onSubmitSignIn);

  }

  void onSubmitSignIn(SubminSignIn event, Emitter<SignInState> emit) async {
    
    emit(SignInLoading());

    final datastate = await _signInUseCase(params: event.signinReq);

    if(datastate is DataSuccess && datastate.data!.success){
      emit(SignInSuccess(datastate.data!));
    }

    if(datastate is DataSuccess && !datastate.data!.success){
      emit(SignInFail(datastate.data!));
    }

    if(datastate is DataFailed){
      emit(SignInError(datastate.error!));
    }
  }
}