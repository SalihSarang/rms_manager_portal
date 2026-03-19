import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/table_management/data/datasources/hall_remote_datasource.dart';
import 'package:manager_portal/features/table_management/data/datasources/table_remote_datasource.dart';
import 'package:manager_portal/features/table_management/data/repositories/hall_repository_impl.dart';
import 'package:manager_portal/features/table_management/data/repositories/table_repository_impl.dart';
import 'package:manager_portal/features/table_management/domain/repositories/hall_repository.dart';
import 'package:manager_portal/features/table_management/domain/repositories/table_repository.dart';
import 'package:manager_portal/features/table_management/domain/usecases/hall_usecases/add_hall_use_case.dart';
import 'package:manager_portal/features/table_management/domain/usecases/hall_usecases/delete_hall_use_case.dart';
import 'package:manager_portal/features/table_management/domain/usecases/hall_usecases/get_halls_use_case.dart';
import 'package:manager_portal/features/table_management/domain/usecases/hall_usecases/update_hall_use_case.dart';
import 'package:manager_portal/features/table_management/domain/usecases/table_usecases/add_table_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/table_usecases/delete_table_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/table_usecases/get_all_table_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/table_usecases/get_tables_by_hall_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/table_usecases/update_table_usecase.dart';
import 'package:manager_portal/features/table_management/presentation/cubit/table_editor_cubit.dart';

void setUpTableManagementDI() {
  // Datasources
  getIt.registerLazySingleton<IHallRemoteDataSource>(
    () => HallRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ITableRemoteDataSource>(
    () => TableRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<IHallRepository>(
    () => HallRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ITableRepository>(
    () => TableRepositoryImpl(getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetHallsUseCase>(() => GetHallsUseCase(getIt()));
  getIt.registerLazySingleton<AddHallUseCase>(() => AddHallUseCase(getIt()));
  getIt.registerLazySingleton<UpdateHallUseCase>(
    () => UpdateHallUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeleteHallUseCase>(
    () => DeleteHallUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetTablesByHallUseCase>(
    () => GetTablesByHallUseCase(getIt()),
  );
  getIt.registerLazySingleton<AddTableUseCase>(() => AddTableUseCase(getIt()));
  getIt.registerLazySingleton<UpdateTableUseCase>(
    () => UpdateTableUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeleteTableUseCase>(
    () => DeleteTableUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetAllTablesUseCase>(
    () => GetAllTablesUseCase(getIt()),
  );

  // BloCs / Cubits
  getIt.registerFactory<TableEditorCubit>(
    () => TableEditorCubit(getIt(), getIt()),
  );
}
