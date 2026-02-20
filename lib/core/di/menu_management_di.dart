import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/menu_management/data/datasources/menu_remote_datasource.dart';
import 'package:manager_portal/features/menu_management/data/repository/menu_repository_impl.dart';
import 'package:manager_portal/features/menu_management/domain/repository/menu_repository.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/add_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_categories_usecase.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_bloc.dart';

void setUpMenuManagementDI() {
  // Datasources
  getIt.registerLazySingleton<MenuRemoteDatasource>(
    () => MenuRemoteDatasourceImpl(firestore: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(getIt()),
  );

  // UseCases
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt()),
  );
  getIt.registerLazySingleton<AddCategoryUseCase>(
    () => AddCategoryUseCase(getIt()),
  );

  // Bloc
  getIt.registerFactory(() => MenuManagementBloc(getIt(), getIt()));
}
