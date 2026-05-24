import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/menu_management/data/datasources/category_remote_datasource.dart';
import 'package:manager_portal/features/menu_management/data/datasources/food_remote_datasource.dart';
import 'package:manager_portal/features/menu_management/data/repository/category_repository_impl.dart';
import 'package:manager_portal/features/menu_management/data/repository/food_repository_impl.dart';
import 'package:manager_portal/features/menu_management/domain/repository/category_repository.dart';
import 'package:manager_portal/features/menu_management/domain/repository/food_repository.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/add_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/add_food_item_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_all_food_items_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_categories_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_food_items_by_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/update_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/update_food_item_usecase.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';

void setUpMenuManagementDI() {
  // Datasources
  getIt.registerLazySingleton<ICategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(firestore: getIt()),
  );
  getIt.registerLazySingleton<IFoodRemoteDataSource>(
    () => FoodRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<ICategoryRepository>(
    () => CategoryRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<IFoodRepository>(
    () => FoodRepositoryImpl(getIt()),
  );

  // UseCases
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt()),
  );
  getIt.registerLazySingleton<AddCategoryUseCase>(
    () => AddCategoryUseCase(getIt()),
  );
  getIt.registerLazySingleton<UpdateCategoryUseCase>(
    () => UpdateCategoryUseCase(getIt()),
  );
<<<<<<< HEAD
  getIt.registerLazySingleton<AddFoodItemUsecase>(
    () => AddFoodItemUsecase(getIt()),
  );
  getIt.registerLazySingleton<UpdateFoodItemUsecase>(
    () => UpdateFoodItemUsecase(getIt()),
=======
  getIt.registerLazySingleton<AddFoodItemUseCase>(
    () => AddFoodItemUseCase(getIt()),
  );
  getIt.registerLazySingleton<UpdateFoodItemUseCase>(
    () => UpdateFoodItemUseCase(getIt()),
>>>>>>> main
  );
  getIt.registerLazySingleton<GetFoodItemsByCategoryUseCase>(
    () => GetFoodItemsByCategoryUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetAllFoodItemsUseCase>(
    () => GetAllFoodItemsUseCase(getIt()),
  );

  // Bloc
  getIt.registerFactory(
    () => AddCategoryBloc(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory(
    () => AddMenuItemBloc(
      foodImgPickerUsecase: getIt(),
<<<<<<< HEAD
      addFoodItemUsecase: getIt(),
      updateFoodItemUsecase: getIt(),
=======
      addFoodItemUseCase: getIt(),
      updateFoodItemUseCase: getIt(),
>>>>>>> main
    ),
  );
}
