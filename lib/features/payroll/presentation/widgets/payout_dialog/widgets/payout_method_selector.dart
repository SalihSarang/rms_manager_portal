import 'package:flutter/material.dart';

import 'package:rms_shared_package/enums/enums.dart';

import 'payout_method_chip.dart';

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
        PayoutMethodChip(
          method: PaymentMethod.cash,
          icon: Icons.money_rounded,
          label: 'Cash',
          isSelected: selectedMethod == PaymentMethod.cash,
          onTap: () => onMethodChanged(PaymentMethod.cash),
        ),
        const SizedBox(width: 8),
        PayoutMethodChip(
          method: PaymentMethod.upi,
          icon: Icons.qr_code_rounded,
          label: 'UPI',
          isSelected: selectedMethod == PaymentMethod.upi,
          onTap: () => onMethodChanged(PaymentMethod.upi),
        ),
        const SizedBox(width: 8),
        PayoutMethodChip(
          method: PaymentMethod.bankTransfer,
          icon: Icons.account_balance_rounded,
          label: 'Bank',
          isSelected: selectedMethod == PaymentMethod.bankTransfer,
          onTap: () => onMethodChanged(PaymentMethod.bankTransfer),
        ),
      ],
    );
  }
}
