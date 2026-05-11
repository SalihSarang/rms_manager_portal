import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class PayoutStaffSummary extends StatelessWidget {
  final StaffModel staff;
  final double baseAmount;
  final double incentive;
  final double deduction;

  const PayoutStaffSummary({
    super.key,
    required this.staff,
    required this.baseAmount,
    this.incentive = 0.0,
    this.deduction = 0.0,
  });

  double get totalAmount => (baseAmount + incentive - deduction).clamp(0.0, double.infinity);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            NeutralColors.white.withValues(alpha: 0.05),
            NeutralColors.white.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: NeutralColors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      PrimaryColors.defaultColor,
                      PrimaryColors.defaultColor.withValues(alpha: 0.7),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: PrimaryColors.defaultColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    staff.name[0].toUpperCase(),
                    style: const TextStyle(
                      color: TextColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      staff.name,
                      style: const TextStyle(
                        color: TextColors.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      staff.role.name.toUpperCase(),
                      style: TextStyle(
                        color: TextColors.secondary.withValues(alpha: 0.5),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'TOTAL PAYOUT',
                    style: TextStyle(
                      color: TextColors.secondary.withValues(alpha: 0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    '₹${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: PrimaryColors.defaultColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildSmallRow('Base Amount', baseAmount),
                if (incentive > 0)
                  _buildSmallRow('Incentive', incentive, color: StatusColors.ready, prefix: '+'),
                if (deduction > 0)
                  _buildSmallRow('Deduction', deduction, color: StatusColors.cancelled, prefix: '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallRow(String label, double value, {Color? color, String? prefix}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: TextColors.secondary.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
          Text(
            '${prefix ?? ''}₹${value.toStringAsFixed(2)}',
            style: TextStyle(
              color: color ?? TextColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
