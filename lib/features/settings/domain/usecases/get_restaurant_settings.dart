import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/settings/domain/repositories/settings_repository.dart';

class GetRestaurantSettingsUseCase {
  final ISettingsRepository repository;

  GetRestaurantSettingsUseCase(this.repository);

  Future<RestaurantModel> call() {
    return repository.getRestaurantSettings();
  }
}
