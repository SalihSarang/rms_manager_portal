import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';

class PayrollPaymentInfo extends StatelessWidget {
  final SalaryCalculationResult result;
  final VoidCallback onPayTap;

  const PayrollPaymentInfo({
    super.key,
    required this.result,
    required this.onPayTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = result.totalDue <= 0;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Due Amount',
              style: TextStyle(color: TextColors.secondary, fontSize: 12),
            ),
            Text(
              '₹${result.totalDue.toStringAsFixed(2)}',
              style: TextStyle(
                color: isCompleted ? StatusColors.ready : TextColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        isCompleted
            ? Row(
                children: const [
                  Icon(Icons.check_circle, color: StatusColors.ready),
                  SizedBox(width: 8),
                  Text(
                    'Paid',
                    style: TextStyle(
                      color: StatusColors.ready,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: onPayTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColors.defaultColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ],
    );
  }
}
