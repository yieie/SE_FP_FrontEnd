
import 'package:dio/dio.dart';
import 'package:front_end/features/data/datasources/remote/admin_api_service.dart';
import 'package:front_end/features/data/datasources/remote/ann_api_service.dart';
import 'package:front_end/features/data/datasources/remote/auth_api_service.dart';
import 'package:front_end/features/data/datasources/remote/competition_api_service.dart';
import 'package:front_end/features/data/datasources/remote/score_api_service.dart';
import 'package:front_end/features/data/datasources/remote/user_management_api_service.dart';
import 'package:front_end/features/data/datasources/remote/workshop_api_service.dart';
import 'package:front_end/features/data/repositories/admin_repository_impl.dart';
import 'package:front_end/features/data/repositories/ann_repository_impl.dart';
import 'package:front_end/features/data/repositories/auth_repository_impl.dart';
import 'package:front_end/features/data/repositories/competition_repository_impl.dart';
import 'package:front_end/features/data/repositories/score_repository_impl.dart';
import 'package:front_end/features/data/repositories/user_management_repository_impl.dart';
import 'package:front_end/features/data/repositories/workshop_repository_impl.dart';
import 'package:front_end/features/domain/repositories/admin_repository.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';
import 'package:front_end/features/domain/repositories/auth_repository.dart';
import 'package:front_end/features/domain/repositories/competition_repository.dart';
import 'package:front_end/features/domain/repositories/score_repository.dart';
import 'package:front_end/features/domain/repositories/user_management_repository.dart';
import 'package:front_end/features/domain/repositories/workshop_repository.dart';
import 'package:front_end/features/domain/usecases/admin/add_new_announcement.dart';
import 'package:front_end/features/domain/usecases/admin/edit_old_announcement.dart';
import 'package:front_end/features/domain/usecases/admin/get_vertify_team.dart';
import 'package:front_end/features/domain/usecases/admin/update_team_state.dart';
import 'package:front_end/features/domain/usecases/edit_profile.dart';
import 'package:front_end/features/domain/usecases/get_10_announcement.dart';
import 'package:front_end/features/domain/usecases/get_competition_info_by_teamid.dart';
import 'package:front_end/features/domain/usecases/get_competition_info_by_uid.dart';
import 'package:front_end/features/domain/usecases/get_detail_announcement.dart';
import 'package:front_end/features/domain/usecases/get_overview.dart';
import 'package:front_end/features/domain/usecases/get_past_project.dart';
import 'package:front_end/features/domain/usecases/get_score_list.dart';
import 'package:front_end/features/domain/usecases/get_teach_team_list.dart';
import 'package:front_end/features/domain/usecases/get_workshop.dart';
import 'package:front_end/features/domain/usecases/get_workshop_participation.dart';
import 'package:front_end/features/domain/usecases/join_workshop.dart';
import 'package:front_end/features/domain/usecases/scoring_team.dart';
import 'package:front_end/features/domain/usecases/search_user_by_uid.dart';
import 'package:front_end/features/domain/usecases/sign_in.dart';
import 'package:front_end/features/domain/usecases/sign_up.dart';
import 'package:front_end/features/domain/usecases/sign_up_competition.dart';
import 'package:front_end/features/presentation/bloc/admin/ann_modify_add_bloc.dart';
import 'package:front_end/features/presentation/bloc/admin/overview_bloc.dart';
import 'package:front_end/features/presentation/bloc/admin/vertify_team_bloc.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_in_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_up_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/get_competition_info_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_bloc.dart';
import 'package:front_end/features/presentation/bloc/past_project_bloc.dart';
import 'package:front_end/features/presentation/bloc/score/score_list_bloc.dart';
import 'package:front_end/features/presentation/bloc/score/score_list_event.dart';
import 'package:front_end/features/presentation/bloc/score/score_team_bloc.dart';
import 'package:front_end/features/presentation/bloc/teacher/teach_team_bloc.dart';
import 'package:front_end/features/presentation/bloc/user_management/profile_manage_bloc.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_list_bloc.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_bloc.dart';
import 'package:front_end/mock/mock_response.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();

  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,      // 是否打印請求的 body
      responseBody: true,     // 是否打印回應的 body
      requestHeader: true,    // 是否打印請求頭
      responseHeader: true,   // 是否打印回應頭
      error: true,            // 是否打印錯誤信息
    ),
  );
  
 //攔截回應測試json解析是否正確
  dio.interceptors.add(mockInterceptor()); 
 

  
  sl.registerSingleton<Dio>(dio);

  sl.registerSingleton<AnnApiService>(AnnApiService(sl()));
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<WorkshopApiService>(WorkshopApiService(sl()));
  sl.registerSingleton<UserManagementApiService>(UserManagementApiService(sl()));
  sl.registerSingleton<CompetitionApiService>(CompetitionApiService(sl()));
  sl.registerSingleton<ScoreApiService>(ScoreApiService(sl()));
  sl.registerSingleton<AdminApiService>(AdminApiService(sl()));

  sl.registerSingleton<AnnRepository>(
    AnnRepositoryImpl(sl())
  );
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl())
  );
  sl.registerSingleton<WorkshopRepository>(
    WorkshopRepositoryImpl(sl())
  );
  sl.registerSingleton<UserManagementRepository>(
    UserManagementRepositoryimpl(sl())
  );
  sl.registerSingleton<CompetitionRepository>(
    CompetitionRepositoryImpl(sl())
  );
  sl.registerSingleton<ScoreRepository>(
    ScoreRepositoryImpl(sl())
  );
  sl.registerSingleton<AdminRepository>(
    AdminRepositoryImpl(sl())
  );

  sl.registerSingleton<Get10AnnouncementUseCase>(
    Get10AnnouncementUseCase(sl())
  );
  sl.registerSingleton<GetDetailAnnouncementUseCase>(
    GetDetailAnnouncementUseCase(sl())
  );
  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(sl())
  );
  sl.registerSingleton<SignInUseCase>(
    SignInUseCase(sl())
  );
  sl.registerSingleton<GetWorkshopUseCase>(
    GetWorkshopUseCase(sl())
  );
  sl.registerSingleton<GetWorkshopParticipationUseCase>(
    GetWorkshopParticipationUseCase(sl())
  );
  sl.registerSingleton<JoinWorkshopUseCase>(
    JoinWorkshopUseCase(sl())
  );
  sl.registerSingleton<SearchUserByUidUseCase>(
    SearchUserByUidUseCase(sl())
  );
  sl.registerSingleton<EditProfileUseCase>(
    EditProfileUseCase(sl())
  );
  sl.registerSingleton<SignUpCompetitionUseCase>(
    SignUpCompetitionUseCase(sl())
  );
  sl.registerSingleton<GetScoreListUseCase>(
    GetScoreListUseCase(sl())
  );
  sl.registerSingleton<ScoringTeamUseCase>(
    ScoringTeamUseCase(sl())
  );
  sl.registerSingleton<GetOverviewUseCase>(
    GetOverviewUseCase(sl())
  );
  sl.registerSingleton<AddNewAnnouncementUseCase>(
    AddNewAnnouncementUseCase(sl())
  );
  sl.registerSingleton<EditOldAnnouncementUseCase>(
    EditOldAnnouncementUseCase(sl())
  );
  sl.registerSingleton<GetCompetitionInfoByTeamIDUseCase>(
    GetCompetitionInfoByTeamIDUseCase(sl())
  );
  sl.registerSingleton<GetCompetitionInfoByUIDUseCase>(
    GetCompetitionInfoByUIDUseCase(sl())
  );
  sl.registerSingleton<GetPastProjectUseCase>(
    GetPastProjectUseCase(sl())
  );
  sl.registerSingleton<GetVertifyTeamUseCase>(
    GetVertifyTeamUseCase(sl())
  );
  sl.registerSingleton<UpdateTeamStateUseCase>(
    UpdateTeamStateUseCase(sl())
  );
  sl.registerSingleton<GetTeachTeamListUseCase>(
    GetTeachTeamListUseCase(sl())
  );

  sl.registerFactory<AuthBloc>(
    ()=> AuthBloc()
  );
  sl.registerFactory<AnnBloc>(
    ()=> AnnBloc(sl(), sl())
  );
  sl.registerFactory<SignUpBloc>(
    () => SignUpBloc(sl())
  );
  sl.registerFactory<SignInBloc>(
    () => SignInBloc(sl())
  );
  sl.registerFactory<WorkshopBloc>(
    () => WorkshopBloc(sl())
  );
  sl.registerFactory<WorkshopParticipationBloc>(
    () => WorkshopParticipationBloc(sl(),sl())
  );
  sl.registerFactory<ProfileManageBloc>(
    () => ProfileManageBloc(sl(),sl())
  );
  sl.registerFactory<SignUpCompetitionBloc>(
    () => SignUpCompetitionBloc(sl(),sl())
  );
  sl.registerFactory<ScoreListBloc>(
    () => ScoreListBloc(sl(),sl())
  );
  sl.registerFactory<ScoreTeamBloc>(
    () => ScoreTeamBloc(sl(),sl())
  );
  sl.registerFactory<OverviewBloc>(
    () => OverviewBloc(sl())
  );
  sl.registerFactory<AnnModifyAddBloc>(
    () => AnnModifyAddBloc(sl(),sl())
  );
  sl.registerFactory<PastProjectBloc>(
    () => PastProjectBloc(sl(),sl())
  );
  sl.registerFactory<VertifyTeamBloc>(
    () => VertifyTeamBloc(sl(),sl(),sl())
  );
  sl.registerFactory<GetCompetitionInfoBloc>(
    () => GetCompetitionInfoBloc(sl())
  );
  sl.registerFactory<TeachTeamBloc>(
    () => TeachTeamBloc(sl(),sl())
  );
}
