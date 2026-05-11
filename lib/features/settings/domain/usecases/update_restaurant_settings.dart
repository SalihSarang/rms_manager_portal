import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/settings/domain/repositories/settings_repository.dart';

class UpdateRestaurantSettingsUseCase {
  final ISettingsRepository repository;

  UpdateRestaurantSettingsUseCase(this.repository);

  Future<void> call(RestaurantModel settings) {
    return repository.updateRestaurantSettings(settings);
  }
}
