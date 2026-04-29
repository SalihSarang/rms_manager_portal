import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';
import 'package:manager_portal/features/overview/presentation/widgets/charts/revenue_trend_chart.dart';
import 'package:manager_portal/features/overview/presentation/widgets/charts/order_volume_chart.dart';

class OverviewChartsRow extends StatelessWidget {
  final OverviewData data;
  final Timeframe timeframe;
  final DateTime? startDate;
  final DateTime? endDate;

  const OverviewChartsRow({
    super.key,
    required this.data,
    required this.timeframe,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 400,
            child: RevenueTrendChart(
              data: data.revenueTrend,
              timeframe: timeframe,
              startDate: startDate,
              endDate: endDate,
            ),
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
