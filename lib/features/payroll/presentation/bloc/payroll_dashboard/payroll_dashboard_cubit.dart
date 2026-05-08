import 'package:flutter_bloc/flutter_bloc.dart';
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

  PayrollDashboardCubit({
    required this.staffRepository,
    required this.shiftRepository,
    required this.calculateSalaryUseCase,
  }) : super(const PayrollDashboardState());

  Future<void> loadPayrollData() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final staffList = await staffRepository.getAllStaffs();
      final validStaff = staffList.whereType<StaffModel>().toList();
      
      final Map<String, SalaryCalculationResult> results = {};
      
      for (var staff in validStaff) {
        final shifts = await shiftRepository.getShiftHistory(staff.id, limit: 100);
        final result = calculateSalaryUseCase.execute(staff, shifts);
        results[staff.id] = result;
      }

      emit(state.copyWith(
        isLoading: false,
        staffList: validStaff,
        calculationResults: results,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load payroll data: ${e.toString()}',
      ));
    }
  }

  void updateWageTypeFilter(WageType? wageType) {
    emit(state.copyWith(
      selectedWageType: wageType,
      clearWageType: wageType == null,
    ));
  }

  void updateStatusFilter(String status) {
    emit(state.copyWith(selectedStatus: status));
  }
}
