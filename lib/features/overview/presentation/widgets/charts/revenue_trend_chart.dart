import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_bloc.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_event.dart';
import 'package:rms_design_system/rms_design_system.dart';

class RevenueTrendChart extends StatelessWidget {
  final List<RevenuePoint> data;
  final Timeframe timeframe;
  final DateTime? startDate;
  final DateTime? endDate;

  const RevenueTrendChart({
    super.key,
    required this.data,
    required this.timeframe,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Revenue Trend',
                    style: TextStyle(
                      color: TextColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeframe == Timeframe.today || timeframe == Timeframe.yesterday
                        ? 'Hourly performance'
                        : timeframe == Timeframe.last7Days
                            ? 'Daily performance over current week'
                            : timeframe == Timeframe.last30Days
                                ? 'Daily performance over last 30 days'
                                : (startDate != null && endDate != null
                                    ? 'From ${startDate!.day}/${startDate!.month} to ${endDate!.day}/${endDate!.month}'
                                    : 'Custom date range'),
                    style: const TextStyle(
                      color: TextColors.secondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              PopupMenuButton<Timeframe>(
                initialValue: timeframe,
                onSelected: (selected) async {
                  if (selected == Timeframe.custom) {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      if (context.mounted) {
                        context.read<OverviewBloc>().add(
                          LoadOverviewData(
                            timeframe: Timeframe.custom,
                            startDate: picked.start,
                            endDate: picked.end,
                          ),
                        );
                      }
                    }
                  } else {
                    context.read<OverviewBloc>().add(LoadOverviewData(timeframe: selected));
                  }
                },
                itemBuilder: (context) => Timeframe.values.map((t) {
                  return PopupMenuItem(
                    value: t,
                    child: Text(t.label),
                  );
                }).toList(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: NeutralColors.border,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        timeframe == Timeframe.custom && startDate != null && endDate != null
                            ? '${startDate!.day}/${startDate!.month} - ${endDate!.day}/${endDate!.month}'
                            : timeframe.label,
                        style: const TextStyle(color: TextColors.primary, fontSize: 12),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, color: TextColors.secondary, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value < 0 || value >= data.length) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            data[value.toInt()].day,
                            style: const TextStyle(
                              color: TextColors.muted,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.amount);
                    }).toList(),
                    isCurved: true,
                    color: PrimaryColors.defaultColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          PrimaryColors.defaultColor.withValues(alpha: 0.3),
                          PrimaryColors.defaultColor.withValues(alpha: 0),
                        ],

                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => NeutralColors.border,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
