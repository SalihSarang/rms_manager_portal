import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'order_section_header.dart';
import 'order_section_items.dart';
import 'order_section_footer.dart';
import '../../../../core/utils/ui_utils.dart';

class OrderSectionCard extends StatelessWidget {
  final OrderModel order;

  const OrderSectionCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: UiUtils.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          OrderSectionHeader(order: order),

          const Divider(color: NeutralColors.border, height: 1),

          // Items Section
          OrderSectionItems(order: order),

          // Order Footer
          OrderSectionFooter(order: order),
        ],
      ),
    );
  }
}
