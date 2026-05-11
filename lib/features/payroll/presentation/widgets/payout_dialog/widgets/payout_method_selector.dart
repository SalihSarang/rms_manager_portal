import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';

class PayoutMethodSelector extends StatelessWidget {
  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onMethodChanged;

  const PayoutMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildMethodChip(PaymentMethod.cash, Icons.money_rounded, 'Cash'),
        const SizedBox(width: 8),
        _buildMethodChip(PaymentMethod.upi, Icons.qr_code_rounded, 'UPI'),
        const SizedBox(width: 8),
        _buildMethodChip(
          PaymentMethod.bankTransfer,
          Icons.account_balance_rounded,
          'Bank',
        ),
      ],
    );
  }

  Widget _buildMethodChip(PaymentMethod method, IconData icon, String label) {
    final bool isSelected = selectedMethod == method;
    return Expanded(
      child: GestureDetector(
        onTap: () => onMethodChanged(method),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? PrimaryColors.defaultColor.withValues(alpha: 0.1)
                : NeutralColors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? PrimaryColors.defaultColor.withValues(alpha: 0.5)
                  : NeutralColors.white.withValues(alpha: 0.05),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? PrimaryColors.defaultColor
                    : TextColors.secondary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? TextColors.primary : TextColors.secondary,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
