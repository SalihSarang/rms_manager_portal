import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:manager_portal/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements ISettingsRepository {
  final ISettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl(this.remoteDataSource);

  @override
  Future<RestaurantModel> getRestaurantSettings() {
    return remoteDataSource.getRestaurantSettings();
  }

  @override
  Future<void> updateRestaurantSettings(RestaurantModel settings) {
    return remoteDataSource.updateRestaurantSettings(settings);
  }
}
