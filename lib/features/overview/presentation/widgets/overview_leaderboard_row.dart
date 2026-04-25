import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/presentation/widgets/wait_staff_leaderboard.dart';
import 'package:manager_portal/features/overview/presentation/widgets/best_selling_items.dart';

class OverviewLeaderboardRow extends StatelessWidget {
  final OverviewData data;

  const OverviewLeaderboardRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: WaitStaffLeaderboard(entries: data.waitStaffLeaderboard),
        ),
        const SizedBox(width: 32),
        Expanded(child: BestSellingItems(entries: data.bestSellingItems)),
      ],
    );
  }
}
