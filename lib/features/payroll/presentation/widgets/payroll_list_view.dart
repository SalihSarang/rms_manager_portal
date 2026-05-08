import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_card.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payout_confirmation_dialog.dart';

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
              builder: (context) => PayoutConfirmationDialog(
                staff: staff,
                calculationResult: result,
                onConfirm: (amount) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Processing ₹$amount for ${staff.name} via RazorpayX...',
                      ),
                      backgroundColor: PrimaryColors.defaultColor,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
