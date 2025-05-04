
import 'package:dio/dio.dart';
import 'package:front_end/features/data/datasources/remote/ann_api_service.dart';
import 'package:front_end/features/data/datasources/remote/auth_api_service.dart';
import 'package:front_end/features/data/repositories/ann_repository_impl.dart';
import 'package:front_end/features/data/repositories/auth_repository_impl.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';
import 'package:front_end/features/domain/repositories/auth_repository.dart';
import 'package:front_end/features/domain/usecases/get_10_announcement.dart';
import 'package:front_end/features/domain/usecases/get_detail_announcement.dart';
import 'package:front_end/features/domain/usecases/sign_up.dart';
import 'package:front_end/features/presentation/bloc/ann_bloc.dart';
import 'package:front_end/features/presentation/bloc/sign_up_bloc.dart';
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
  
  sl.registerSingleton<Dio>(dio);

  sl.registerSingleton<AnnApiService>(AnnApiService(sl()));
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));

  sl.registerSingleton<AnnRepository>(
    AnnRepositoryImpl(sl())
  );
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl())
  );

  sl.registerSingleton<Get10AnnouncementUseCase>(
    Get10AnnouncementUseCase(sl())
  );
  sl.registerSingleton<GetDetailAnnouncementUseCase>(
    GetDetailAnnouncementUseCase(sl())
  );
  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase()
  );

  sl.registerFactory<AnnBloc>(
    ()=> AnnBloc(sl(), sl())
  );
  sl.registerFactory<SignUpBloc>(
    () => SignUpBloc(sl())
  );
}

void setupDio() {
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

  // 註冊 Dio 實例到 DI 容器
  sl.registerSingleton<Dio>(dio);
}