import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth_event.dart';
import 'package:front_end/features/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc():super(AuthInitial()){
    on<AppStarted> (onAppStarted);
    on<LoggedIn> (onLoggedIn);
    on<LoggedOut> (onLoggedOut);
  }

  void onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(Unauthenticated());
  }

  void onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    print('🔁 Received LoggedIn event with uid: ${event.uid} usertype: ${event.usertype}');
    emit(Authenticated(usertype: event.usertype, uid: event.uid));
    print(state);
  }

  void onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(Unauthenticated());
  }
}