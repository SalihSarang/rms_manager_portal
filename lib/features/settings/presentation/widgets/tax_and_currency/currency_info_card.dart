import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class CurrencyInfoCard extends StatelessWidget {
  const CurrencyInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Currency',
          style: TextStyle(
            color: TextColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: NeutralColors.border),
          ),
          child: const Row(
            children: [
              Icon(Icons.payments_outlined, color: PrimaryColors.defaultColor),
              SizedBox(width: 12),
              Text(
                'Indian Rupee (INR - ₹)',
                style: TextStyle(color: TextColors.primary, fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.check_circle, color: PrimaryColors.defaultColor),
            ],
          ),
        ),
      ],
    );
  }
}
