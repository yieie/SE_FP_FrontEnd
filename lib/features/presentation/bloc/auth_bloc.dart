import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth_event.dart';
import 'package:front_end/features/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc():super(AuthInitial()){
    on<AppStarted> (onAppStarted);
    on<LoggedIn> (onLoggedIn);
    on<LoggedOut> (onLoggedOut);
  }

  void onAppStarted(AppStarted event, Emitter<AuthState> emit){
    emit(Unauthenticated());
  }

  void onLoggedIn(LoggedIn event, Emitter<AuthState> emit){
    emit(Authenticated(usertype: event.usertype, uid: event.uid));
  }

  void onLoggedOut(LoggedOut event, Emitter<AuthState> emit){
    emit(Unauthenticated());
  }
}