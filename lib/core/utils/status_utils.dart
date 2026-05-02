import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/table_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';

class StatusUtils {
  static Color getOrderStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return StatusColors.pending;
      case OrderStatus.preparing:
        return StatusColors.preparing;
      case OrderStatus.ready:
        return StatusColors.ready;
      case OrderStatus.served:
        return StatusColors.purpleLight;
      case OrderStatus.completed:
        return StatusColors.paid;
    }
  }

  static bool hasActiveOrder(List<OrderModel> orders) => orders.isNotEmpty;

  static int getTotalGuests(TableModel table, List<OrderModel> orders) {
    if (orders.isEmpty) return table.occupiedSeats;
    return orders.fold(0, (sum, order) => sum + order.seatCount);
  }

  static String getWaiterNames(List<OrderModel> orders) {
    if (orders.isEmpty) return 'No Waiter Assigned';
    final names = orders.map((o) => o.staffName).toSet().toList();
    return names.join(', ');
  }

  static Color getTableStatusColor(TableModel table, List<OrderModel> orders) {
    final totalGuests = getTotalGuests(table, orders);

    // 1. Fully Occupied logic (Alert - Red)
    if (totalGuests >= table.seats) {
      return TableColors.destructive;
    }

    if (orders.isEmpty) return TextColors.secondary;

    // 2. Pending Order logic (Yellow) - If ANY order is pending
    if (orders.any((o) => o.orderStatus == OrderStatus.pending)) {
      return StatusColors.pending;
    }

    // 3. Preparing logic (Blue) - If any is preparing
    if (orders.any((o) => o.orderStatus == OrderStatus.preparing)) {
      return StatusColors.preparing;
    }

    // 4. Ready logic (Green)
    if (orders.any((o) => o.orderStatus == OrderStatus.ready)) {
      return StatusColors.ready;
    }

    // 5. Served logic (Purple)
    if (orders.any((o) => o.orderStatus == OrderStatus.served)) {
      return StatusColors.purpleLight;
    }

    return StatusColors.preparing;
  }

  static String getTableStatusText(TableModel table, List<OrderModel> orders) {
    final totalGuests = getTotalGuests(table, orders);

    if (totalGuests >= table.seats) return 'Fully Occupied';
    if (orders.isEmpty) return 'Available';

    if (orders.any((o) => o.orderStatus == OrderStatus.pending)) {
      return 'Pending Order';
    }
    if (orders.any((o) => o.orderStatus == OrderStatus.preparing)) {
      return 'Preparing';
    }
    if (orders.any((o) => o.orderStatus == OrderStatus.ready)) {
      return 'Ready';
    }
    if (orders.any((o) => o.orderStatus == OrderStatus.served)) {
      return 'Served';
    }

    return 'Occupied';
  }
}
