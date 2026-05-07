import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/enums/enums.dart';

class PayrollDashboardState extends Equatable {
  final WageType? selectedWageType;
  final String selectedStatus;

  const PayrollDashboardState({
    this.selectedWageType,
    this.selectedStatus = 'Pending',
  });

  PayrollDashboardState copyWith({
    WageType? selectedWageType,
    bool clearWageType = false,
    String? selectedStatus,
  }) {
    return PayrollDashboardState(
      selectedWageType: clearWageType ? null : (selectedWageType ?? this.selectedWageType),
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }

  @override
  List<Object?> get props => [selectedWageType, selectedStatus];
}
