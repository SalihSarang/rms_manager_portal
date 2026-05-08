import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_cubit.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_state.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_empty_view.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_error_view.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_list_view.dart';
import 'package:manager_portal/features/payroll/utils/payroll_utils.dart';

class PayrollDashboardBody extends StatelessWidget {
  const PayrollDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayrollDashboardCubit, PayrollDashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return PayrollErrorView(
            errorMessage: state.errorMessage!,
            onRetry: () =>
                context.read<PayrollDashboardCubit>().loadPayrollData(),
          );
        }

        // Apply filters using Utility class
        final filteredStaff = PayrollUtils.filterStaff(
          staffList: state.staffList,
          calculationResults: state.calculationResults,
          selectedWageType: state.selectedWageType,
          selectedStatus: state.selectedStatus,
        );

        if (filteredStaff.isEmpty) {
          return const PayrollEmptyView();
        }

        return PayrollListView(
          staffList: filteredStaff,
          calculationResults: state.calculationResults,
        );
      },
    );
  }
}
