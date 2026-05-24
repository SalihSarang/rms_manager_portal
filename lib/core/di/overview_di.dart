import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/overview/data/datasources/overview_remote_datasource.dart';
import 'package:manager_portal/features/overview/data/repositories/overview_repository_impl.dart';
import 'package:manager_portal/features/overview/domain/repositories/overview_repository.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_bloc.dart';

void setUpOverviewDI() {
  // Datasource
  getIt.registerLazySingleton<OverviewRemoteDataSource>(
    () => OverviewRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<OverviewRepository>(
    () => OverviewRepositoryImpl(
      remoteDataSource: getIt(),
      foodRemoteDataSource: getIt(),
      staffRemoteDataSource: getIt(),
    ),
  );

  // Bloc
  getIt.registerFactory<OverviewBloc>(
    () => OverviewBloc(repository: getIt()),
  );
}
