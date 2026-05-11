import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final RestaurantModel settings;

  SettingsLoaded(this.settings);

  @override
  List<Object?> get props => [settings];
}

class SettingsUpdateSuccess extends SettingsLoaded {
  SettingsUpdateSuccess(super.settings);
}

class SettingsError extends SettingsState {
  final String message;

  SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
