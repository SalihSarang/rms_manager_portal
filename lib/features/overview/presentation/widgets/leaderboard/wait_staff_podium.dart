import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:rms_design_system/rms_design_system.dart';

class WaitStaffPodium extends StatelessWidget {
  final List<LeaderboardEntry> top3;

  const WaitStaffPodium({super.key, required this.top3});

  @override
  Widget build(BuildContext context) {
    if (top3.isEmpty) return const SizedBox();

    final first = top3[0];
    final second = top3.length > 1 ? top3[1] : null;
    final third = top3.length > 2 ? top3[2] : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (second != null) ...[
          Expanded(child: _buildPodiumCard(second, 2, 160, Colors.grey[400]!)),
          const SizedBox(width: 24),
        ] else
          const Expanded(child: SizedBox()),
        
        Expanded(child: _buildPodiumCard(first, 1, 200, Colors.amber[600]!)),
        const SizedBox(width: 24),

        if (third != null)
          Expanded(child: _buildPodiumCard(third, 3, 140, Colors.brown[400]!))
        else
          const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _buildPodiumCard(LeaderboardEntry entry, int rank, double height, Color accentColor) {
    return Container(
      height: height + 120,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: rank == 1 ? accentColor.withValues(alpha: 0.5) : NeutralColors.border,
          width: rank == 1 ? 2 : 1,
        ),
        boxShadow: [
          if (rank == 1)
            BoxShadow(
              color: accentColor.withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: rank == 1 ? 40 : 32,
                backgroundImage: NetworkImage(entry.staff.avatar),
                backgroundColor: NeutralColors.border,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#$rank',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            entry.staff.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: TextColors.primary,
              fontSize: rank == 1 ? 16 : 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${entry.ordersCount} Orders',
            style: const TextStyle(
              color: TextColors.secondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '\$${entry.revenue.toStringAsFixed(2)}',
            style: TextStyle(
              color: PrimaryColors.brandGreen,
              fontSize: rank == 1 ? 20 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Revenue',
            style: TextStyle(
              color: TextColors.muted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
