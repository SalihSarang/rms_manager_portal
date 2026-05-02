import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';
import 'table_status_card_header.dart';
import 'table_status_info_row.dart';
import 'table_status_multi_order_badge.dart';
import 'table_status_waiter_info.dart';

class TableStatusCardContent extends StatelessWidget {
  final TableModel table;
  final List<OrderModel> activeOrders;
  final String statusText;
  final Color statusColor;
  final bool hasActiveOrder;
  final bool showAsAvailable;
  final int totalGuests;
  final String waiterNames;
  final String? duration;

  const TableStatusCardContent({
    super.key,
    required this.table,
    required this.activeOrders,
    required this.statusText,
    required this.statusColor,
    required this.hasActiveOrder,
    required this.showAsAvailable,
    required this.totalGuests,
    required this.waiterNames,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Opacity(
        opacity: showAsAvailable ? 0.35 : 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableStatusCardHeader(
              table: table,
              statusText: statusText,
              statusColor: statusColor,
              showAsAvailable: showAsAvailable,
            ),

            const SizedBox(height: 24),

            TableStatusInfoRow(
              totalGuests: totalGuests,
              duration: duration,
              hasActiveOrder: hasActiveOrder,
              statusColor: statusColor,
            ),

            const Spacer(),

            TableStatusMultiOrderBadge(orderCount: activeOrders.length),

            const Divider(color: NeutralColors.border, height: 16),

            TableStatusWaiterInfo(waiterNames: waiterNames),
          ],
        ),
      ),
    );
  }
}
