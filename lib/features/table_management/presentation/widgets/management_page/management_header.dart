import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'components/stat_card.dart';

/// Header widget for the [TableManagementPage].
///
/// Displays the title and key statistics like [hallCount] and [totalTables].
class ManagementHeader extends StatelessWidget {
  /// Total number of restaurant halls/sections.
  final int hallCount;

  /// Total number of tables across all halls.
  final int totalTables;

  /// Creates a [ManagementHeader].
  const ManagementHeader({
    super.key,
    required this.hallCount,
    required this.totalTables,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Restaurant Overview',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: NeutralColors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Visualize and manage your restaurant layout across $hallCount sections.',
                style: TextStyle(
                  fontSize: 15,
                  color: NeutralColors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        StatCard(
          icon: Icons.grid_view_rounded,
          label: 'Sections',
          value: '$hallCount',
          color: PrimaryColors.defaultColor,
        ),
        const SizedBox(width: 16),
        StatCard(
          icon: Icons.table_restaurant_rounded,
          label: 'Total Tables',
          value: '$totalTables',
          color: Colors.blueAccent,
        ),
      ],
    );
  }
}
