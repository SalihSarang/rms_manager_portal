import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_cubit.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_state.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_filter_chip.dart';

class PayrollFilters extends StatelessWidget {
  const PayrollFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayrollDashboardCubit, PayrollDashboardState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: NeutralColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.filter_list, color: TextColors.secondary, size: 20),
                  SizedBox(width: 8),
                  Text('Filters', style: TextStyle(color: TextColors.primary, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Status Filters
                  PayrollFilterChip(
                    label: 'Pending',
                    isSelected: state.selectedStatus == 'Pending',
                    onSelected: (selected) {
                      if (selected) context.read<PayrollDashboardCubit>().updateStatusFilter('Pending');
                    },
                  ),
                  const SizedBox(width: 8),
                  PayrollFilterChip(
                    label: 'Completed',
                    isSelected: state.selectedStatus == 'Completed',
                    onSelected: (selected) {
                      if (selected) context.read<PayrollDashboardCubit>().updateStatusFilter('Completed');
                    },
                  ),
                  
                  const SizedBox(width: 24),
                  Container(width: 1, height: 30, color: NeutralColors.border),
                  const SizedBox(width: 24),

                  // Wage Type Filters
                  PayrollFilterChip(
                    label: 'All Wages',
                    isSelected: state.selectedWageType == null,
                    onSelected: (selected) {
                      if (selected) context.read<PayrollDashboardCubit>().updateWageTypeFilter(null);
                    },
                  ),
                  const SizedBox(width: 8),
                  PayrollFilterChip(
                    label: 'Hourly',
                    isSelected: state.selectedWageType == WageType.hourly,
                    onSelected: (selected) {
                      if (selected) context.read<PayrollDashboardCubit>().updateWageTypeFilter(WageType.hourly);
                    },
                  ),
                  const SizedBox(width: 8),
                  PayrollFilterChip(
                    label: 'Monthly',
                    isSelected: state.selectedWageType == WageType.monthly,
                    onSelected: (selected) {
                      if (selected) context.read<PayrollDashboardCubit>().updateWageTypeFilter(WageType.monthly);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
