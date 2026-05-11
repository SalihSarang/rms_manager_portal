import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:manager_portal/features/payroll/data/datasources/payout_remote_datasource.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_cubit.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_state.dart';
import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/repositories/shift_repository.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';

class MockStaffRepository extends Mock implements StaffRepository {}

class MockShiftRepository extends Mock implements ShiftRepository {}

class MockCalculateSalaryUseCase extends Mock
    implements CalculateSalaryUseCase {}

class MockPayoutRemoteDataSource extends Mock
    implements PayoutRemoteDataSource {}

void main() {
  late StaffRepository staffRepository;
  late ShiftRepository shiftRepository;
  late CalculateSalaryUseCase calculateSalaryUseCase;
  late PayoutRemoteDataSource payoutDataSource;

  setUp(() {
    staffRepository = MockStaffRepository();
    shiftRepository = MockShiftRepository();
    calculateSalaryUseCase = MockCalculateSalaryUseCase();
    payoutDataSource = MockPayoutRemoteDataSource();
  });

  group('PayrollDashboardCubit', () {
    blocTest<PayrollDashboardCubit, PayrollDashboardState>(
      'emits [isLoading: true, isLoading: false] when loadPayrollData is successful with empty list',
      build: () {
        when(() => staffRepository.getAllStaffs()).thenAnswer((_) async => []);
        return PayrollDashboardCubit(
          staffRepository: staffRepository,
          shiftRepository: shiftRepository,
          calculateSalaryUseCase: calculateSalaryUseCase,
          payoutDataSource: payoutDataSource,
        );
      },
      act: (cubit) => cubit.loadPayrollData(),
      expect: () => [
        const PayrollDashboardState(isLoading: true),
        const PayrollDashboardState(isLoading: false, staffList: []),
      ],
    );

    blocTest<PayrollDashboardCubit, PayrollDashboardState>(
      'emits [isLoading: true, errorMessage] when loadPayrollData fails',
      build: () {
        when(
          () => staffRepository.getAllStaffs(),
        ).thenThrow(Exception('Error'));
        return PayrollDashboardCubit(
          staffRepository: staffRepository,
          shiftRepository: shiftRepository,
          calculateSalaryUseCase: calculateSalaryUseCase,
          payoutDataSource: payoutDataSource,
        );
      },
      act: (cubit) => cubit.loadPayrollData(),
      expect: () => [
        const PayrollDashboardState(isLoading: true),
        isA<PayrollDashboardState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          contains('Error'),
        ),
      ],
    );
  });
}
