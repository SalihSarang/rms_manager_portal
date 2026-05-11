import 'package:flutter/material.dart';
import 'widgets/payout_account_details.dart';
import 'widgets/payout_action_buttons.dart';
import 'widgets/payout_method_selector.dart';
import 'widgets/payout_staff_summary.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class ManualPayoutDialog extends StatefulWidget {
  final StaffModel staff;
  final double amount;
  final Function(PaymentMethod method, String notes) onConfirm;

  const ManualPayoutDialog({
    super.key,
    required this.staff,
    required this.amount,
    required this.onConfirm,
  });

  @override
  State<ManualPayoutDialog> createState() => _ManualPayoutDialogState();
}

class _ManualPayoutDialogState extends State<ManualPayoutDialog> {
  PaymentMethod _selectedMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: NeutralColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 440),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm Payout',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: TextColors.primary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Review and record this manual payment',
              style: TextStyle(
                color: TextColors.secondary.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            PayoutStaffSummary(staff: widget.staff, amount: widget.amount),
            const SizedBox(height: 32),
            const Text(
              'PAYMENT METHOD',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: TextColors.secondary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            PayoutMethodSelector(
              selectedMethod: _selectedMethod,
              onMethodChanged: (method) =>
                  setState(() => _selectedMethod = method),
            ),
            const SizedBox(height: 24),
            if (_selectedMethod != PaymentMethod.cash)
              PayoutAccountDetails(
                staff: widget.staff,
                selectedMethod: _selectedMethod,
              ),
            const SizedBox(height: 32),
            PayoutActionButtons(
              onCancel: () => Navigator.pop(context),
              onConfirm: () {
                widget.onConfirm(_selectedMethod, '');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
