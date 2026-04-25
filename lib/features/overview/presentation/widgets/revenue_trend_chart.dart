import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:rms_design_system/rms_design_system.dart';

class RevenueTrendChart extends StatelessWidget {
  final List<RevenuePoint> data;

  const RevenueTrendChart({super.key, required this.data});

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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Revenue Trend',
                    style: TextStyle(
                      color: TextColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Daily performance over current week',
                    style: TextStyle(
                      color: TextColors.secondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: NeutralColors.border,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Last 7 Days',
                      style: TextStyle(color: TextColors.primary, fontSize: 12),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: TextColors.secondary, size: 16),
                  ],
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
