import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/usecases/search_user_by_uid.dart';
import 'package:front_end/features/presentation/bloc/user_management/search_user_event.dart';
import 'package:front_end/features/presentation/bloc/user_management/search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final SearchUserByUidUseCase _searchUserByUidUseCase;

  SearchUserBloc(this._searchUserByUidUseCase):super(SearchInitial()){
    on<SearchUserbyUID> (onSearchUserbyUID);
  }

  void onSearchUserbyUID(SearchUserbyUID event, Emitter<SearchUserState> emit) async {
    final datastate = await _searchUserByUidUseCase(params: event.uid);

    if(datastate is DataSuccess){
      print("got it");
      emit(
        SearchDone(user: datastate.data!)
      );
    }

    if(datastate is DataFailed){
      emit(
        SearchError(error: datastate.error!)
      );
    }
  }
}