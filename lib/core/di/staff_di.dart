import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/staff/data/datasources/staff_datasource.dart';
import 'package:manager_portal/features/staff/data/repository/staff_repo_impl.dart';
import 'package:manager_portal/features/staff/domain/repository/staff_repository.dart';
import 'package:manager_portal/features/staff/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff/presentation/bloc/staff_listing/staff_listing_bloc.dart';

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

  // Staff Listing Bloc
  getIt.registerFactory<StaffListingBloc>(() => StaffListingBloc());

  // Add Staff Bloc
  getIt.registerFactory<AddStaffBloc>(
    () => AddStaffBloc(avatarPicker: getIt()),
  );
}
