import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'payroll_dashboard_state.dart';

class PayrollDashboardCubit extends Cubit<PayrollDashboardState> {
  PayrollDashboardCubit() : super(const PayrollDashboardState());

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
