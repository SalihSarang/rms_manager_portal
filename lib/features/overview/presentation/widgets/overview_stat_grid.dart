import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/presentation/widgets/stat_card.dart';
import 'package:rms_design_system/rms_design_system.dart';

class OverviewStatGrid extends StatelessWidget {
  final OverviewData data;

  const OverviewStatGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      childAspectRatio: 1.5,
      children: [
        StatCard(
          title: 'Total Revenue',
          value: '\$${data.summaryStats.totalRevenue.toStringAsFixed(2)}',
          icon: Icons.attach_money,
          iconColor: PrimaryColors.defaultColor,
        ),
        StatCard(
          title: 'Total Orders',
          value: '${data.summaryStats.totalOrders}',
          icon: Icons.shopping_cart_outlined,
          iconColor: PrimaryColors.defaultColor,
        ),
        StatCard(
          title: 'Active Chef',
          value: '${data.summaryStats.activeChefs}',
          subtitle: '/ ${data.summaryStats.totalChefs}',
          icon: Icons.group_outlined,
          iconColor: PrimaryColors.defaultColor,
        ),
        StatCard(
          title: 'Active Waiters',
          value: '${data.summaryStats.activeWaiters}',
          subtitle: '/ ${data.summaryStats.totalWaiters}',
          icon: Icons.group_outlined,
          iconColor: PrimaryColors.defaultColor,
        ),
      ],
    );
  }
}
