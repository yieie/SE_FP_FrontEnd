import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/CompetitionForm.dart';
import 'package:front_end/features/domain/entity/identity/Attendee.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';
import 'package:front_end/features/domain/entity/identity/Teacher.dart';
import 'package:front_end/features/domain/usecases/edit_competition_info.dart';
import 'package:front_end/features/domain/usecases/get_competition_info_by_uid.dart';
import 'package:front_end/features/domain/usecases/search_user_by_uid.dart';
import 'package:front_end/features/domain/usecases/sign_up_competition.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_event.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_state.dart';
import 'package:file_picker/file_picker.dart';

class SignUpCompetitionBloc extends Bloc<SignUpCompetitionEvent, SignUpCompetitionState> {
  final SearchUserByUidUseCase _searchUserByUidUseCase;
  final SignUpCompetitionUseCase _signUpCompetitionUseCase;
  final GetCompetitionInfoByUIDUseCase _getCompetitionInfoByUIDUseCase;
  final EditCompetitionInfoUseCase _editCompetitionInfoUseCase;

  SignUpCompetitionBloc(this._searchUserByUidUseCase, this._signUpCompetitionUseCase,this._getCompetitionInfoByUIDUseCase,this._editCompetitionInfoUseCase) : super(SignUpCompetitionState(status: SubmissionStatus.initial, currentPage: 0)) {
    on<ResetSubmissionStatus>((event, emit) {
      emit(state.copyWith(
        status: SubmissionStatus.initial,
        error: null,
        errorMessage: '',
      ));
    });
    
    on<LoadMainUserEvent> (onLoadMainUser);
    on<LoadTeamInfoEvent> (onLoadTeamInfo);
    on<AddTeammateEvent> (onAddTeammate);
    on<AddTeacherEvent> (onAddTeacher);
    on<SubmitCompetitionFormEvent> (onSubmitCompetitionForm);

    on<EditCompetitionFormEvent> (onEditCompetitionFormEvent);

    on<GoToNextPage>((event, emit) {
      if (state.currentPage < 2) {
        emit(state.copyWith(currentPage: state.currentPage + 1));
      }
    });

    on<GoToPreviousPage>((event, emit) {
      if (state.currentPage > 0) {
        emit(state.copyWith(currentPage: state.currentPage - 1));
      }
    });

    on<UpdateFieldEvent>((event, emit) {
      final newState = _updateField(state, event.field, event.value);
      emit(newState);
    });

    on<UploadStudentCard>((event,emit){
      final updateStudentIDcard = List<PlatformFile?>.from(state.studentCard);
      updateStudentIDcard[event.order] = event.studentCard;
      emit(state.copyWith(studentCard: updateStudentIDcard));
    });

  }

  void onLoadMainUser(LoadMainUserEvent event, Emitter emit) async {
    final datastate = await _searchUserByUidUseCase(params: event.uid);
    final user = datastate.data;
    if(datastate is DataSuccess ){
      if(user is Student){
        final updatedList = List<Student>.from(state.members)
          ..add(user);
        final updateStudentIDcard = List<PlatformFile?>.from(state.studentCard)..add(null);
        emit(
          state.copyWith(members: updatedList , studentCard:  updateStudentIDcard)
        );
      }
    }
    if(datastate is DataFailed){
      emit(
        state.copyWith(status: SubmissionStatus.failure, error: datastate.error)
      );
    }
  }

  void onLoadTeamInfo(LoadTeamInfoEvent event, Emitter emit) async {
    final dataState = await _getCompetitionInfoByUIDUseCase(params: event.uid);

    if(dataState is DataSuccess){
      final teamproject = dataState.data!;
      final memberAmount = teamproject.team.members!.length;
      final uploadStudentCard = List<PlatformFile?>.filled(memberAmount, null);
      emit(
        state.copyWith(
          teamName: teamproject.team.name,
          teamType: teamproject.team.type,
          projectName: teamproject.project.name,
          projectAbstract: teamproject.project.abstract,
          ytUrl: teamproject.project.url!.firstWhere(
                  (url) => url.contains('youtube.com') || url.contains('youtu.be'),
                  orElse: () => ''),
          githubUrl: teamproject.project.url!.firstWhere(
                    (url) => url.contains('github.com'),
                    orElse: () => '',),
          sdgs: teamproject.project.sdgs!.split(',').map((e) => int.parse(e.trim())).toSet(),
          studentCard: uploadStudentCard,
          cloudmembers: teamproject.team.members,
          teacherID: teamproject.team.teacher?.uid,
          teacherName: teamproject.team.teacher?.name,
          teacherTitle: teamproject.team.teacher?.title,
          teacherDepartment: teamproject.team.teacher?.department,
          teacherOrganization: teamproject.team.teacher?.organization,
          cloudIntroductionFile: teamproject.project.introductionFile,
          cloudAffidavitFile: teamproject.project.affidavitFile,
          cloudConsentFile: teamproject.project.consentFile
        )
      );
    }

    if(dataState is DataFailed){
      emit(state.copyWith(status: SubmissionStatus.failure, error: dataState.error));
    }
  }

  void onAddTeammate(AddTeammateEvent event, Emitter emit) async {

    final datastate = await _searchUserByUidUseCase(params: event.uid);
    final teammate = datastate.data;

    if(datastate is DataSuccess ){  
      if(teammate is Student){

        final updatedList = List<Student>.from(state.members)
          ..add(teammate);
        final updateStudentIDcard = List<PlatformFile?>.from(state.studentCard)..add(null);

        emit(state.copyWith(members: updatedList,studentCard: updateStudentIDcard));
      }
      else{
        emit(state.copyWith(status: SubmissionStatus.failure, errorMessage: "該帳號非學生帳號，請與隊員確認帳號是否無誤"));
      }
    }
    if(datastate is DataFailed){
      emit(state.copyWith(status: SubmissionStatus.failure, error: datastate.error));
    }
  }

  void onAddTeacher(AddTeacherEvent event, Emitter emit) async{
    final datastate = await _searchUserByUidUseCase(params: event.uid);
    final user = datastate.data;
    if(datastate is DataSuccess ){
      if(user is Teacher){
        emit(
          state.copyWith(teacherID: user.uid, teacherName: user.name, teacherTitle: user.title,teacherDepartment: user.department,teacherOrganization: user.organization)
        );
      }
      else{
        emit(
          state.copyWith(status: SubmissionStatus.failure,errorMessage: "該使用者非教師，請再次確認")
        );
      }
    }
    if(datastate is DataFailed){
      emit(
        state.copyWith(error: datastate.error)
      );
    }
  }

  void onSubmitCompetitionForm(SubmitCompetitionFormEvent event, Emitter emit) async {
    

    List<String> missingFields = [];

    final s = state; // 簡寫

    // 文字欄位
    if (s.teamName.trim().isEmpty) missingFields.add('隊名');
    if (s.teamType.trim().isEmpty) missingFields.add('隊伍類型');
    if (s.projectName.trim().isEmpty) missingFields.add('作品名稱');
    if (s.projectAbstract.trim().isEmpty) missingFields.add('作品摘要');
    if (s.ytUrl.trim().isEmpty) missingFields.add('YouTube 連結');
    if (s.githubUrl.trim().isEmpty) missingFields.add('GitHub 連結');

    // 列表類型
    if (s.members.length < 2) missingFields.add('隊員不可小於兩位');
    if (s.studentCard.isEmpty || s.studentCard.any((f) => f == null)) {
      missingFields.add('學生證');
    }

    // 檔案類型
    if (s.introductionFile == null) missingFields.add('作品說明書');
    if (s.consentFile == null) missingFields.add('個資同意書');
    if (s.affidavitFile == null) missingFields.add('提案切結書');

    if(missingFields.isEmpty){
      emit(state.copyWith(status: SubmissionStatus.submitting));

      final CompetitionForm competitionForm = CompetitionForm(
        teamName: state.teamName,
        type: state.teamType,
        leader: state.members[0].uid,
        members: List<({String studentID, PlatformFile idCard})>.generate(
          state.members.length,
          (i) => (studentID: state.members[i].uid!, idCard: state.studentCard[i]!),
        ),
        teacherID: state.teacherID,
        workName: state.projectName,
        abstract: state.projectAbstract,
        sdgs: state.sdgs.join(','),
        introductionFile: state.introductionFile,
        consentFile: state.consentFile,
        affidavitFile: state.affidavitFile,
        url: [state.ytUrl, state.githubUrl]
      );

      final datastate = await _signUpCompetitionUseCase(params: competitionForm);

      if(datastate is DataSuccess ){  
        emit(
          state.copyWith(status: SubmissionStatus.success)
        );
      }
      if(datastate is DataFailed){
        emit(state.copyWith(status: SubmissionStatus.failure, error: datastate.error));
      }
    }else{
      final message = '以下欄位未填寫或無效：${missingFields.join('、')}';
      emit(state.copyWith(status: SubmissionStatus.failure,errorMessage: message));
    }
  }

  void onEditCompetitionFormEvent(EditCompetitionFormEvent event, Emitter emit) async {
    final original = await _getCompetitionInfoByUIDUseCase(params: event.uid);
    List<({String studentID, PlatformFile idCard})> list = List.generate(state.cloudmembers.length,(i) => (
                studentID: state.cloudmembers[i]!.uid!,
                idCard: state.studentCard[i],
              ),
            ).where((e) => e.idCard != null).map<({String studentID, PlatformFile idCard})>(
              (e) => (studentID: e.studentID, idCard: e.idCard!)
            )
            .toList();

    CompetitionForm form = CompetitionForm(
      abstract: state.projectAbstract,
      members: list,
      sdgs: state.sdgs.join(','),
      url: [state.ytUrl,state.githubUrl],
    );
    final dataState = await _editCompetitionInfoUseCase(data: form,teamid: original.data!.team.members![0].teamID,workid: original.data!.team.members![0].workID);
  }

  SignUpCompetitionState _updateField(
    SignUpCompetitionState state,
    String field,
    dynamic value,
  ) {
    switch (field) {
      case 'errorMessage':
        return state.copyWith(errorMessage: value as String);
      case 'error':
        return state.copyWith(error: value as DioException);
      case 'teamName':
        return state.copyWith(teamName: value as String);
      case 'teamType':
        return state.copyWith(teamType: value as String);
      case 'projectName':
        return state.copyWith(projectName: value as String);
      case 'projectAbstract':
        return state.copyWith(projectAbstract: value as String);
      case 'ytUrl':
        return state.copyWith(ytUrl: value as String);
      case 'githubUrl':
        return state.copyWith(githubUrl: value as String);
      case 'sdgs':
        return state.copyWith(sdgs: value as Set<int>);
      case 'consent':
        return state.copyWith(consentFile: value as PlatformFile);
      case 'affidavit':
        return state.copyWith(affidavitFile: value as PlatformFile);
      case 'introduction':
        return state.copyWith(introductionFile: value as PlatformFile);
      default:
        return state;
    }
}
}
