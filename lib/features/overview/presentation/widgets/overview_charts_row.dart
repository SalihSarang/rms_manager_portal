import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/presentation/widgets/revenue_trend_chart.dart';
import 'package:manager_portal/features/overview/presentation/widgets/order_volume_chart.dart';

class OverviewChartsRow extends StatelessWidget {
  final OverviewData data;

  const OverviewChartsRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 400,
            child: RevenueTrendChart(data: data.revenueTrend),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 400,
            child: OrderVolumeChart(data: data.orderVolume),
          ),
        ),
      ],
    );
  }
}
