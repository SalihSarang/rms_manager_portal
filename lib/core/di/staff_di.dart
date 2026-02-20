import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff_management/data/datasources/staff_datasource.dart';
import 'package:manager_portal/features/staff_management/data/repository/staff_repo_impl.dart';
import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/add_new_staff.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/create_staff_user.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/delete_staff.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_all_staffs.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_staff_details.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/update_staff.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';

void setUpStaffDI() {
  // Datasource
  getIt.registerLazySingleton<StaffDatasource>(
    () => StaffDatasourceImpl(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<StaffRepository>(
    () => StaffRepositoryImpl(staffDatasource: getIt<StaffDatasource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetAllStaffs(getIt()));
  getIt.registerLazySingleton(() => GetStaffDetails(getIt()));
  getIt.registerLazySingleton(() => AddNewStaff(getIt()));
  getIt.registerLazySingleton(() => CreateStaffUser(getIt()));
  getIt.registerLazySingleton(() => DeleteStaffUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateStaffUsecase(getIt()));

  // Staff Listing Bloc
  getIt.registerFactory<StaffListingBloc>(
    () => StaffListingBloc(
      getAllStaffs: getIt(),
      getStaffDetails: getIt(),
      deleteStaff: getIt(),
      cloudinaryService: getIt(),
    ),
  );

  // Add Staff Bloc
  getIt.registerFactory<AddStaffBloc>(
    () => AddStaffBloc(
      avatarPicker: getIt(),
      addNewStaff: getIt(),
      createStaffUser: getIt(),
      updateStaff: getIt(),
      cloudinaryService: getIt(),
    ),
  );
}
