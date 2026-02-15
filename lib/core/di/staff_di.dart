import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff/presentation/bloc/staff_bloc.dart';

void setUpStaffDI() {
  // Staff Bloc
  // Staffs: Adding, Display, Deleting,
  getIt.registerFactory<StaffBloc>(() => StaffBloc(avatarPicker: getIt()));
}
