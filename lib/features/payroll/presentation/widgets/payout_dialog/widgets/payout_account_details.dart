import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class PayoutAccountDetails extends StatelessWidget {
  final StaffModel staff;
  final PaymentMethod selectedMethod;

  const PayoutAccountDetails({
    super.key,
    required this.staff,
    required this.selectedMethod,
  });

  @override
  Widget build(BuildContext context) {
    final bankDetails = staff.bankDetails;
    final isUpi = selectedMethod == PaymentMethod.upi;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NeutralColors.shadow.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isUpi ? Icons.info_outline : Icons.account_balance_outlined,
                size: 14,
                color: PrimaryColors.defaultColor,
              ),
              const SizedBox(width: 8),
              Text(
                isUpi ? 'VERIFY UPI ID' : 'VERIFY BANK DETAILS',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: PrimaryColors.defaultColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (isUpi)
            _buildDetailRow('UPI ID', bankDetails?['upiId'] ?? 'Not set')
          else ...[
            _buildDetailRow('Bank', bankDetails?['bankName'] ?? 'Not set'),
            _buildDetailRow(
              'Account',
              bankDetails?['accountNumber'] ?? 'Not set',
            ),
            _buildDetailRow('IFSC', bankDetails?['ifscCode'] ?? 'Not set'),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
            value,
            style: const TextStyle(
              color: TextColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
