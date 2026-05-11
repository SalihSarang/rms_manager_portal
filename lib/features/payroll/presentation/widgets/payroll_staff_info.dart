import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';

class PayrollStaffInfo extends StatelessWidget {
  final StaffModel staff;
  final SalaryCalculationResult result;

  const PayrollStaffInfo({
    super.key,
    required this.staff,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    staff.wageType == WageType.hourly ? 'Hourly' : 'Monthly',
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
              style: const TextStyle(color: TextColors.secondary, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
