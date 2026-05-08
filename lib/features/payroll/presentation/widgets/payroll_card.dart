import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';

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
    final bool isCompleted = result.totalDue <= 0;

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
          Row(
            children: [
              CircleAvatar(
                backgroundColor: NeutralColors.border,
                child: Text(
                  staff.name[0],
                  style: const TextStyle(color: TextColors.primary),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        staff.name,
                        style: const TextStyle(
                          color: TextColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: NeutralColors.background,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: NeutralColors.border),
                        ),
                        child: Text(
                          staff.wageType == WageType.hourly
                              ? 'Hourly'
                              : 'Monthly',
                          style: const TextStyle(
                            color: TextColors.secondary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(result.totalMinutesWorked / 60).toStringAsFixed(1)} Hours Worked',
                    style: const TextStyle(
                      color: TextColors.secondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
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
                      color: isCompleted
                          ? StatusColors.ready
                          : TextColors.primary,
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
          ),
        ],
      ),
    );
  }
}
