import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';

class PayrollDashboardState extends Equatable {
  final WageType? selectedWageType;
  final String selectedStatus;
  final bool isLoading;
  final List<StaffModel> staffList;
  final Map<String, SalaryCalculationResult> calculationResults;
  final String? errorMessage;

  const PayrollDashboardState({
    this.selectedWageType,
    this.selectedStatus = 'Pending',
    this.isLoading = false,
    this.staffList = const [],
    this.calculationResults = const {},
    this.errorMessage,
  });

  PayrollDashboardState copyWith({
    WageType? selectedWageType,
    bool clearWageType = false,
    String? selectedStatus,
    bool? isLoading,
    List<StaffModel>? staffList,
    Map<String, SalaryCalculationResult>? calculationResults,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PayrollDashboardState(
      selectedWageType: clearWageType
          ? null
          : (selectedWageType ?? this.selectedWageType),
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
      staffList: staffList ?? this.staffList,
      calculationResults: calculationResults ?? this.calculationResults,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    selectedWageType,
    selectedStatus,
    isLoading,
    staffList,
    calculationResults,
    errorMessage,
  ];
}
