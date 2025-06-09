import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/admin/get_user_list.dart';
import 'package:front_end/features/presentation/bloc/admin/user_event.dart';
import 'package:front_end/features/presentation/bloc/admin/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final GetUserListUseCase _getUserListUseCase;

  UserBloc(this._getUserListUseCase):super(UserInitial()){
    on<GetUserListEvent> (onGetUserListEvent);
  }

  void onGetUserListEvent(GetUserListEvent event,Emitter emit) async {
    emit(
      UserLoading()
    );
    final dataState = await _getUserListUseCase(page: event.page, usertype: event.usertype);

    if(dataState is DataSuccess){
      emit(
        UserListLoaded(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      emit(
        UserError(dataState.error!)
      );
    }

  }
}