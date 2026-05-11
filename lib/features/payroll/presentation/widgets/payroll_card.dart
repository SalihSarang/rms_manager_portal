import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_staff_info.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_payment_info.dart';

class PayrollCard extends StatelessWidget {
  final StaffModel staff;
  final SalaryCalculationResult result;
  final VoidCallback onPayTap;

  const PayrollCard({
    super.key,
    required this.staff,
    required this.result,
    required this.onPayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PayrollStaffInfo(staff: staff, result: result),
          PayrollPaymentInfo(result: result, onPayTap: onPayTap),
        ],
      ),
    );
  }
}
