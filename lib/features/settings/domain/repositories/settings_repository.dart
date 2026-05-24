import 'package:rms_shared_package/rms_shared_package.dart';

abstract class ISettingsRepository {
  Future<RestaurantModel> getRestaurantSettings();
  Future<void> updateRestaurantSettings(RestaurantModel settings);
}
