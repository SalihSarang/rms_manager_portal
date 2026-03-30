import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/stats_card/stats_card.dart';

class ActivityStatsCards extends StatelessWidget {
  final int totalStaffs;
  final int activeStaffs;
  final int notActiveStaffs;

  const ActivityStatsCards({
    super.key,
    required this.totalStaffs,
    required this.activeStaffs,
    required this.notActiveStaffs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: StatsCard(
            dotColor: PrimaryColors.lightColor,
            title: 'Total Staffs',
            value: totalStaffs.toString(),
            onTap: () {},
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: StatsCard(
            dotColor: SemanticColors.info,
            title: 'Active',
            value: activeStaffs.toString(),
            onTap: () {},
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: StatsCard(
            dotColor: SemanticColors.error,
            title: 'Not Active',
            value: notActiveStaffs.toString(),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
