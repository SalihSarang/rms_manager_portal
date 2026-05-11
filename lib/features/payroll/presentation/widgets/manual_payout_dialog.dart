import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
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
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Record Manual Payout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: TextColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Staff: ${widget.staff.name}',
              style: const TextStyle(color: TextColors.secondary),
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: ₹${widget.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: PrimaryColors.defaultColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Method',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TextColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            RadioGroup<PaymentMethod>(
              groupValue: _selectedMethod,
              onChanged: (value) {
                if (value != null) setState(() => _selectedMethod = value);
              },
              child: Column(
                children: [
                  _buildMethodOption(PaymentMethod.cash, 'Cash'),
                  _buildMethodOption(PaymentMethod.upi, 'UPI'),
                  _buildMethodOption(
                    PaymentMethod.bankTransfer,
                    'Bank Transfer',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Notes (Optional)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TextColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                hintText: 'Add transaction ID or reference...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    widget.onConfirm(_selectedMethod, _notesController.text);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColors.defaultColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Record Payment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodOption(PaymentMethod method, String label) {
    return RadioListTile<PaymentMethod>(
      value: method,
      title: Text(label),
      contentPadding: EdgeInsets.zero,
      activeColor: PrimaryColors.defaultColor,
    );
  }
}
