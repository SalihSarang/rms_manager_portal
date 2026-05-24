import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:manager_portal/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:manager_portal/features/settings/domain/repositories/settings_repository.dart';
import 'package:manager_portal/features/settings/domain/usecases/get_restaurant_settings.dart';
import 'package:manager_portal/features/settings/domain/usecases/update_restaurant_settings.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_cubit.dart';

void setUpSettingsDI() {
  // Data Sources
  getIt.registerLazySingleton<ISettingsRemoteDataSource>(
    () => SettingsRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<ISettingsRepository>(
    () => SettingsRepositoryImpl(getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetRestaurantSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateRestaurantSettingsUseCase(getIt()));

  // Cubit
  getIt.registerFactory(
    () => SettingsCubit(getSettings: getIt(), updateSettings: getIt()),
  );
}
