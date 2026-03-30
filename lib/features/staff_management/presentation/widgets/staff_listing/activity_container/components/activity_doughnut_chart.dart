import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';

class ActivityDoughnutChart extends StatelessWidget {
  final StaffListingState state;
  final int totalStaffs;
  final int activeStaffs;
  final int notActiveStaffs;

  const ActivityDoughnutChart({
    super.key,
    required this.state,
    required this.totalStaffs,
    required this.activeStaffs,
    required this.notActiveStaffs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 160,
          width: 160,
          child: (state is StaffListingLoading)
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 5,
                        centerSpaceRadius: 60,
                        startDegreeOffset: -90,
                        sections: totalStaffs == 0
                            ? [
                                PieChartSectionData(
                                  color: NeutralColors.border,
                                  value: 1,
                                  title: '',
                                  radius: 20,
                                ),
                              ]
                            : [
                                PieChartSectionData(
                                  color: SemanticColors.info,
                                  value: activeStaffs.toDouble(),
                                  title: '',
                                  radius: 20,
                                ),
                                PieChartSectionData(
                                  color: SemanticColors.error,
                                  value: notActiveStaffs.toDouble(),
                                  title: '',
                                  radius: 20,
                                ),
                              ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          totalStaffs == 0
                              ? '0%'
                              : '${((activeStaffs / totalStaffs) * 100).toInt()}%',
                          style: const TextStyle(
                            color: TextColors.inverse,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Active',
                          style: TextStyle(
                            color: TextColors.secondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
