import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/payroll/data/datasources/payout_remote_datasource.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';
import 'package:manager_portal/features/staff_management/domain/repository/staff_repository.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_shared_package/repositories/shift_repository.dart';
import 'payroll_dashboard_state.dart';

class PayrollDashboardCubit extends Cubit<PayrollDashboardState> {
  final StaffRepository staffRepository;
  final ShiftRepository shiftRepository;
  final CalculateSalaryUseCase calculateSalaryUseCase;
  final PayoutRemoteDataSource payoutDataSource;

  PayrollDashboardCubit({
    required this.staffRepository,
    required this.shiftRepository,
    required this.calculateSalaryUseCase,
    required this.payoutDataSource,
  }) : super(const PayrollDashboardState());

  Future<void> loadPayrollData() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final staffList = await staffRepository.getAllStaffs();
      final validStaff = staffList.whereType<StaffModel>().toList();

      final Map<String, SalaryCalculationResult> results = {};

      for (var staff in validStaff) {
        final shifts = await shiftRepository.getShiftHistory(
          staff.id,
          limit: 100,
        );
        final result = calculateSalaryUseCase.execute(staff, shifts);
        results[staff.id] = result;
      }

      emit(
        state.copyWith(
          isLoading: false,
          staffList: validStaff,
          calculationResults: results,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load payroll data: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> processManualPayout({
    required String staffId,
    required double amount,
    required PaymentMethod paymentMethod,
    String? notes,
  }) async {
    final result = state.calculationResults[staffId];
    if (result == null || result.processedShifts.isEmpty) return;

    emit(state.copyWith(isLoading: true));
    try {
      // 1. Process Payout (Record in database)
      final payout = await payoutDataSource.processPayout(
        staffId: staffId,
        amount: amount,
        periodStart: result.processedShifts.last.actualStart ?? DateTime.now(),
        periodEnd: result.processedShifts.first.actualEnd ?? DateTime.now(),
        paymentMethod: paymentMethod,
        notes: notes,
      );

      // 2. Mark shifts as paid
      final shiftIds = result.processedShifts.map((s) => s.id).toList();
      await shiftRepository.markShiftsAsPaid(staffId, shiftIds, payout.id);

      // 3. Reload data to reflect changes
      await loadPayrollData();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to process payout: ${e.toString()}',
        ),
      );
    }
  }

  void updateWageTypeFilter(WageType? wageType) {
    emit(
      state.copyWith(
        selectedWageType: wageType,
        clearWageType: wageType == null,
      ),
    );
  }

  void updateStatusFilter(String status) {
    emit(state.copyWith(selectedStatus: status));
  }
}
