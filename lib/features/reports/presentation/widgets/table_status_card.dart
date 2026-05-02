import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import '../../../../core/utils/status_utils.dart';
import '../../../../core/utils/ui_utils.dart';
import 'order_details_modal.dart';
import 'table_status_left_indicator.dart';
import 'table_status_open_badge.dart';
import 'table_status_card_content.dart';
import 'table_status_background_icon.dart';

class TableStatusCard extends StatelessWidget {
  final TableModel table;
  final String? waiterName;
  final String? duration;
  final List<OrderModel> activeOrders;

  const TableStatusCard({
    super.key,
    required this.table,
    this.waiterName,
    this.duration,
    required this.activeOrders,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = StatusUtils.getTableStatusColor(
      table,
      activeOrders,
    );
    final String statusText = StatusUtils.getTableStatusText(
      table,
      activeOrders,
    );
    final bool hasActiveOrder = StatusUtils.hasActiveOrder(activeOrders);
    final bool showAsAvailable = !hasActiveOrder;
    final int totalGuests = StatusUtils.getTotalGuests(table, activeOrders);
    final String waiterNames = StatusUtils.getWaiterNames(activeOrders);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (hasActiveOrder) {
            showDialog(
              context: context,
              builder: (context) =>
                  OrderDetailsModal(table: table, orders: activeOrders),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        hoverColor: statusColor.withValues(alpha: 0.05),
        splashColor: statusColor.withValues(alpha: 0.1),
        child: Container(
          decoration: UiUtils.tableStatusCardDecoration(
            showAsAvailable: showAsAvailable,
            statusColor: statusColor,
          ),
          child: Stack(
            children: [
              if (hasActiveOrder)
                TableStatusLeftIndicator(statusColor: statusColor),

              TableStatusCardContent(
                table: table,
                activeOrders: activeOrders,
                statusText: statusText,
                statusColor: statusColor,
                hasActiveOrder: hasActiveOrder,
                showAsAvailable: showAsAvailable,
                totalGuests: totalGuests,
                waiterNames: waiterNames,
                duration: duration,
              ),

              TableStatusOpenBadge(showAsAvailable: showAsAvailable),

              TableStatusBackgroundIcon(showAsAvailable: showAsAvailable),
            ],
          ),
        ),
      ),
    );
  }
}
