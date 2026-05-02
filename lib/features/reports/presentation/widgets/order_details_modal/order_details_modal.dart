import 'package:flutter/material.dart';
import 'package:manager_portal/core/utils/ui_utils.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';
import 'components/order_details_header.dart';
import 'components/order_details_empty_state.dart';
import 'components/order_section_card.dart';
import 'components/order_details_footer.dart';

class OrderDetailsModal extends StatelessWidget {
  final TableModel table;
  final List<OrderModel> orders;

  const OrderDetailsModal({
    super.key,
    required this.table,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Container(
        width: 650,
        constraints: const BoxConstraints(maxHeight: 850),
        decoration: UiUtils.modalDecoration,
        child: Column(
          children: [
            // Header Section
            OrderDetailsHeader(table: table, partyCount: orders.length),

            // Order List
            Expanded(
              child: orders.isEmpty
                  ? const OrderDetailsEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.all(24),
                      itemCount: orders.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 24),
                      itemBuilder: (context, index) =>
                          OrderSectionCard(order: orders[index]),
                    ),
            ),

            // Aggregate Footer
            OrderDetailsFooter(orders: orders),
          ],
        ),
      ),
    );
  }
}
