import 'package:auth_lorby/features/authorization/data/data_source/remote_data_source/authorization_data_source.dart';
import 'package:auth_lorby/features/authorization/data/repository/auth_repo.dart';
import 'package:auth_lorby/features/authorization/domain/use_case/auth_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        headers: {
          'content-Type': 'application/json',
          'accept': '*/*',
        },
      ),
    ),
  );

  getIt.registerSingleton<AuthorizationDataSource>(
    AuthorizationDataSourceImpl(
      dio: getIt<Dio>(),
    ),
  );
  getIt.registerSingleton<AuthorizationRepositoryImpl>(
    AuthorizationRepositoryImpl(
      dataSource: getIt<AuthorizationDataSource>(),
    ),
  );
  getIt.registerSingleton<AuthorizationUseCase>(
    AuthorizationUseCase(
      repository: getIt<AuthorizationRepositoryImpl>(),
    ),
  );
}
