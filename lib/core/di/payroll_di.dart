import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/payroll/data/datasources/payout_remote_datasource.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_cubit.dart';
import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/repositories/firestore_shift_repository.dart';
import 'package:rms_shared_package/repositories/shift_repository.dart';

void setUpPayrollDI() {
  // Data Sources
  getIt.registerLazySingleton<PayoutRemoteDataSource>(
    () => PayoutRemoteDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<ShiftRepository>(
    () => FirestoreShiftRepository(firestore: getIt<FirebaseFirestore>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => CalculateSalaryUseCase());

  // Cubit
  getIt.registerFactory<PayrollDashboardCubit>(
    () => PayrollDashboardCubit(
      staffRepository: getIt<StaffRepository>(),
      shiftRepository: getIt<ShiftRepository>(),
      calculateSalaryUseCase: getIt<CalculateSalaryUseCase>(),
      payoutDataSource: getIt<PayoutRemoteDataSource>(),
    ),
  );
}
