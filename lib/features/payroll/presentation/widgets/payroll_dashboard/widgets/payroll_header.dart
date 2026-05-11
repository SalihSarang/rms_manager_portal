import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PayrollHeader extends StatelessWidget {
  const PayrollHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payroll Management',
          style: TextStyle(
            color: TextColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Review outstanding wages based on completed shifts and process payouts.',
          style: TextStyle(color: TextColors.secondary, fontSize: 14),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
