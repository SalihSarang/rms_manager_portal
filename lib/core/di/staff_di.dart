import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff/presentation/bloc/staff_listing/staff_listing_bloc.dart';

void setUpStaffDI() {
  // Staff Listing Bloc
  getIt.registerFactory<StaffListingBloc>(() => StaffListingBloc());

  // Add Staff Bloc
  getIt.registerFactory<AddStaffBloc>(
    () => AddStaffBloc(avatarPicker: getIt()),
  );
}
