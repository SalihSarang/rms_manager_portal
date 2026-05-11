import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/settings/domain/usecases/get_restaurant_settings.dart';
import 'package:manager_portal/features/settings/domain/usecases/update_restaurant_settings.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetRestaurantSettingsUseCase _getSettings;
  final UpdateRestaurantSettingsUseCase _updateSettings;

  SettingsCubit({
    required GetRestaurantSettingsUseCase getSettings,
    required UpdateRestaurantSettingsUseCase updateSettings,
  }) : _getSettings = getSettings,
       _updateSettings = updateSettings,
       super(SettingsInitial());

  Future<void> loadSettings() async {
    emit(SettingsLoading());
    try {
      final settings = await _getSettings();
      emit(SettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> updateSettings(RestaurantModel settings) async {
    // We don't necessarily want to show a full loading screen for every update
    // but maybe we should for important ones.
    try {
      await _updateSettings(settings);
      emit(SettingsUpdateSuccess(settings));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
