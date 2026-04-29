import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/presentation/widgets/leaderboard/wait_staff_full_list.dart';
import 'package:manager_portal/features/overview/presentation/widgets/leaderboard/wait_staff_podium.dart';
import 'package:rms_design_system/rms_design_system.dart';

class WaitStaffLeaderboardContent extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  const WaitStaffLeaderboardContent({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final top3 = entries.take(3).toList();
    final rest = entries.skip(3).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WaitStaffPodium(top3: top3),
          if (rest.isNotEmpty) ...[
            const SizedBox(height: 40),
            const Text(
              'All Performers',
              style: TextStyle(
                color: TextColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            WaitStaffFullList(restEntries: rest),
          ],
        ],
      ),
    );
  }
}
