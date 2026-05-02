import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/status_utils.dart';

class OrderSectionHeader extends StatelessWidget {
  final OrderModel order;

  const OrderSectionHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final statusColor = StatusUtils.getOrderStatusColor(order.orderStatus);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'ORDER #${order.id.substring(order.id.length - 4).toUpperCase()}',
                    style: const TextStyle(
                      color: TextColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      order.orderStatus.name.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 12,
                    color: TextColors.muted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    order.staffName.toUpperCase(),
                    style: const TextStyle(
                      color: TextColors.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            DateFormat('HH:mm').format(order.createdAt),
            style: const TextStyle(
              color: TextColors.secondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
