import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/identity/Admin.dart';
import 'package:front_end/features/domain/entity/identity/Judge.dart';
import 'package:front_end/features/domain/entity/identity/Lecturer.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';
import 'package:front_end/features/domain/entity/identity/Teacher.dart';
import 'package:front_end/features/domain/usecases/edit_profile.dart';
import 'package:front_end/features/domain/usecases/search_user_by_uid.dart';
import 'package:front_end/features/presentation/bloc/user_management/profile_manage_event.dart';
import 'package:front_end/features/presentation/bloc/user_management/profile_manage_state.dart';

class ProfileManageBloc extends Bloc<ProfileManageEvent, ProfileManageState> {
  final SearchUserByUidUseCase _searchUserByUidUseCase;
  final EditProfileUseCase _editProfileUseCase;

  ProfileManageBloc(this._searchUserByUidUseCase,this._editProfileUseCase):super(ProfileInitial()){
    on<SearchUserbyUID> (onSearchUserbyUID);
    on<EditProfileEvent> (onEditProfileEvent);
  }

  void onSearchUserbyUID(SearchUserbyUID event, Emitter<ProfileManageState> emit) async {
    final datastate = await _searchUserByUidUseCase(params: event.uid);

    if(datastate is DataSuccess){
      emit(
        ProfileLoaded(user: datastate.data!)
      );
    }

    if(datastate is DataFailed){
      emit(
        ProfileError(error: datastate.error!)
      );
    }
  }

  void onEditProfileEvent(EditProfileEvent event, Emitter emit) async{
    emit(ProfileEditting());
    final user;
    if(event.original is Student){
      Student stu = event.original as Student;
      user = Student(
        uid: stu.uid,
        name: event.name == stu.name ? null : event.name,
        sexual: event.sexual == stu.sexual ? null : event.sexual,
        phone: event.phone == stu.phone ? null : event.phone,
        email: event.email == stu.email ? null : event.email,
        department: event.department == stu.department ? null : event.department,
        grade: event.grade == stu.grade ? null : event.grade,
      );
    }else if (event.original is Admin){
      user = Admin(
        uid: event.original.uid,
        name: event.name == event.original.name ? null : event.name,
        sexual: event.sexual == event.original.sexual ? null : event.sexual,
        phone: event.phone == event.original.phone ? null : event.phone,
        email: event.email == event.original.email ? null : event.email,
      );
    }else if(event.original is Teacher){
      Teacher tr = event.original as Teacher;
      user = Teacher(
        uid: tr.uid,
        name: event.name == tr.name ? null : event.name,
        sexual: event.sexual == tr.sexual ? null : event.sexual,
        phone: event.phone == tr.phone ? null : event.phone,
        email: event.email == tr.email ? null : event.email,
        department: event.department == tr.department ? null : event.department,
        organization: event.organization == tr.organization ? null : event.organization,
        title: event.title == tr.title ? null : event.title,
      );
    }else if(event.original is Lecturer){
      Lecturer lecturer = event.original as Lecturer;
      user = Lecturer(
        uid: lecturer.uid,
        name: event.name == lecturer.name ? null : event.name,
        sexual: event.sexual == lecturer.sexual ? null : event.sexual,
        phone: event.phone == lecturer.phone ? null : event.phone,
        email: event.email == lecturer.email ? null : event.email,
        title: event.title == lecturer.title ? null : event.title,
      );
    }else if(event.original is Judge){
      Judge judge = event.original as Judge;
      user = Judge(
        uid: judge.uid,
        name: event.name == judge.name ? null : event.name,
        sexual: event.sexual == judge.sexual ? null : event.sexual,
        phone: event.phone == judge.phone ? null : event.phone,
        email: event.email == judge.email ? null : event.email,
        title: event.title == judge.title ? null : event.title,
      );
    }else{
      user = null;
    }
    print('hello');
    final datastate = await _editProfileUseCase(user: user);
    print('hi');

    if(datastate is DataSuccess){
      emit(
        ProfileSuccess()
      );
    }

    if(datastate is DataFailed){
      emit(
        ProfileError(error: datastate.error!)
      );
    }
  }
}