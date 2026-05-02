import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:manager_portal/core/di/image_picker_di.dart';
import 'package:manager_portal/core/di/manager_auth_di.dart';
import 'package:manager_portal/core/di/menu_management_di.dart';
import 'package:manager_portal/core/di/staff_di.dart';
import 'package:manager_portal/core/di/table_management_di.dart';
import 'package:manager_portal/core/di/overview_di.dart';
import 'package:manager_portal/core/di/reports_di.dart';

final getIt = GetIt.instance;

/// Configures the global dependency injection container using [GetIt].
///
/// Registers all repositories, use cases, and services required by the application.
void setupDI() {
  //Firebase
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  //Manager Auth DI
  managerAuthDI();

  // Image Picker and Cloudinary DI
  setUpImagePicker();

  // Staff Manage DI
  setUpStaffDI();

  // Menu Management DI
  setUpMenuManagementDI();

  // Table Management DI
  setUpTableManagementDI();

  // Overview DI
  setUpOverviewDI();

  // Reports DI
  setUpReportsDI();
}
