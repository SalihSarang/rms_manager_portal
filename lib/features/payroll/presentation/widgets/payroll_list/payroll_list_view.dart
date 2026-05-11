import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';
import 'widgets/payroll_card.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payout_dialog/manual_payout_dialog.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_cubit.dart';

class PayrollListView extends StatelessWidget {
  final List<StaffModel> staffList;
  final Map<String, SalaryCalculationResult> calculationResults;

  const PayrollListView({
    super.key,
    required this.staffList,
    required this.calculationResults,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: staffList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final staff = staffList[index];
        final result = calculationResults[staff.id]!;
        return PayrollCard(
          staff: staff,
          result: result,
          onPayTap: () {
            showDialog(
              context: context,
              builder: (dialogContext) => ManualPayoutDialog(
                staff: staff,
                amount: result.totalDue,
                onConfirm: (method, notes, finalAmount) async {
                  await context
                      .read<PayrollDashboardCubit>()
                      .processManualPayout(
                        staffId: staff.id,
                        amount: finalAmount,
                        paymentMethod: method,
                        notes: notes,
                      );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Payment of ₹${finalAmount.toStringAsFixed(2)} recorded for ${staff.name}',
                        ),
                        backgroundColor: StatusColors.ready,
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
