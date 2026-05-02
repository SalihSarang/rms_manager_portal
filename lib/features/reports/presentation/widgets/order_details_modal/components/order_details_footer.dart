import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';

class OrderDetailsFooter extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderDetailsFooter({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final double totalForTable = orders.fold(
      0,
      (sum, o) => sum + o.totalAmount,
    );

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        border: const Border(top: BorderSide(color: NeutralColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TABLE SUMMARY',
                style: TextStyle(
                  color: TextColors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Aggregate Total Amount',
                style: TextStyle(color: TextColors.secondary, fontSize: 13),
              ),
            ],
          ),
          Text(
            '\$${totalForTable.toStringAsFixed(2)}',
            style: const TextStyle(
              color: StatusColors.ready,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
