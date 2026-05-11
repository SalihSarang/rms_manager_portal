import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

import 'payout_adjustment_pill.dart';

class PayoutAdjustmentsSection extends StatelessWidget {
  final ValueChanged<String> onIncentiveChanged;
  final ValueChanged<String> onDeductionChanged;

  const PayoutAdjustmentsSection({
    super.key,
    required this.onIncentiveChanged,
    required this.onDeductionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ADJUSTMENTS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: TextColors.secondary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: NeutralColors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: NeutralColors.white.withValues(alpha: 0.05),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: PayoutAdjustmentPill(
                  label: 'Incentive',
                  icon: Icons.add_rounded,
                  color: StatusColors.ready,
                  onChanged: onIncentiveChanged,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: NeutralColors.white.withValues(alpha: 0.05),
              ),
              Expanded(
                child: PayoutAdjustmentPill(
                  label: 'Deduction',
                  icon: Icons.remove_rounded,
                  color: StatusColors.cancelled,
                  onChanged: onDeductionChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
