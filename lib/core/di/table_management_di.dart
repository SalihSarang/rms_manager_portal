import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/table_management/data/datasources/table_remote_datasource.dart';
import 'package:manager_portal/features/table_management/data/repository/table_repository_impl.dart';
import 'package:manager_portal/features/table_management/domain/repository/table_repository.dart';
import 'package:manager_portal/features/table_management/domain/usecases/add_table_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/delete_table_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/get_tables_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/update_table_usecase.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_management_bloc.dart';

/// Sets up dependency injection for the table management feature.
void setUpTableManagementDI() {
  // Data Source
  getIt.registerLazySingleton<TableRemoteDataSource>(
    () => TableRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<TableRepository>(
    () => TableRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetTablesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddTableUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateTableUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteTableUseCase(getIt()));

  // BLoC
  getIt.registerFactory(
    () => TableManagementBloc(
      getTablesUseCase: getIt(),
      addTableUseCase: getIt(),
      updateTableUseCase: getIt(),
      deleteTableUseCase: getIt(),
    ),
  );
}
