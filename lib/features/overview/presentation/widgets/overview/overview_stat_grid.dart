import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview/stat_card.dart';
import 'package:rms_design_system/rms_design_system.dart';

class OverviewStatGrid extends StatelessWidget {
  final OverviewData data;

  const OverviewStatGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth < 650
            ? 1
            : constraints.maxWidth < 1050
                ? 2
                : 4;
        final aspectRatio = constraints.maxWidth < 650
            ? 2.6
            : constraints.maxWidth < 1050
                ? 2.0
                : 1.5;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: aspectRatio,
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
      },
    );
  }
}
