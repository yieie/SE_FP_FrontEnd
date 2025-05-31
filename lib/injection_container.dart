
import 'package:dio/dio.dart';
import 'package:front_end/features/data/datasources/remote/ann_api_service.dart';
import 'package:front_end/features/data/datasources/remote/auth_api_service.dart';
import 'package:front_end/features/data/datasources/remote/competition_api_service.dart';
import 'package:front_end/features/data/datasources/remote/user_management_api_service.dart';
import 'package:front_end/features/data/datasources/remote/workshop_api_service.dart';
import 'package:front_end/features/data/repositories/ann_repository_impl.dart';
import 'package:front_end/features/data/repositories/auth_repository_impl.dart';
import 'package:front_end/features/data/repositories/competition_repository_impl.dart';
import 'package:front_end/features/data/repositories/user_management_repository_impl.dart';
import 'package:front_end/features/data/repositories/workshop_repository_impl.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';
import 'package:front_end/features/domain/repositories/auth_repository.dart';
import 'package:front_end/features/domain/repositories/competition_repository.dart';
import 'package:front_end/features/domain/repositories/user_management_repository.dart';
import 'package:front_end/features/domain/repositories/workshop_repository.dart';
import 'package:front_end/features/domain/usecases/get_10_announcement.dart';
import 'package:front_end/features/domain/usecases/get_detail_announcement.dart';
import 'package:front_end/features/domain/usecases/get_workshop.dart';
import 'package:front_end/features/domain/usecases/get_workshop_participation.dart';
import 'package:front_end/features/domain/usecases/join_workshop.dart';
import 'package:front_end/features/domain/usecases/search_user_by_uid.dart';
import 'package:front_end/features/domain/usecases/sign_in.dart';
import 'package:front_end/features/domain/usecases/sign_up.dart';
import 'package:front_end/features/domain/usecases/sign_up_competition.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_in_bloc.dart';
import 'package:front_end/features/presentation/bloc/auth/sign_up_bloc.dart';
import 'package:front_end/features/presentation/bloc/competition/sign_up_competition_bloc.dart';
import 'package:front_end/features/presentation/bloc/user_management/search_user_bloc.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_list_bloc.dart';
import 'package:front_end/features/presentation/bloc/workshop/workshop_participation_bloc.dart';
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
 /*  
 //攔截回應測試json解析是否正確
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print('🚀 [Mock] intercepting request: ${options.uri}');
      if (options.uri.path.contains('getUserInfo.php')) {
        print('🧪 Intercepting: ${options.uri}');
        // 攔截，直接回假資料
        return handler.resolve(Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "success": true,
            "uId": "a1115526",
            "name": "陳小明",
            "email": "a1115526@gmail.com",
            "phone": "0912345678",
            "sexual": "男",
            "userType": "student",
            "studentInfo": {
              "department": "資訊工程學系",
              "grade": "大五"
            },
          },
        ));
      }
      return handler.next(options);
    },
  )); 
  */

  
  sl.registerSingleton<Dio>(dio);

  sl.registerSingleton<AnnApiService>(AnnApiService(sl()));
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<WorkshopApiService>(WorkshopApiService(sl()));
  sl.registerSingleton<UserManagementApiService>(UserManagementApiService(sl()));
  sl.registerSingleton<CompetitionApiService>(CompetitionApiService(sl()));

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
  sl.registerSingleton<SignUpCompetitionUseCase>(
    SignUpCompetitionUseCase(sl())
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
  sl.registerFactory<SearchUserBloc>(
    () => SearchUserBloc(sl())
  );
  sl.registerFactory<SignUpCompetitionBloc>(
    () => SignUpCompetitionBloc(sl(),sl())
  );
}
