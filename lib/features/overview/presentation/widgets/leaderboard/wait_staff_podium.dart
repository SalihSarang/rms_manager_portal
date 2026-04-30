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
        if (second != null)
          Expanded(
            child: _buildPodiumItem(
              context: context,
              entry: second,
              rank: 2,
              height: 220,
              accentColor: const Color(0xFFC0C0C0), // Silver
              icon: Icons.workspace_premium,
            ),
          )
        else
          const Expanded(child: SizedBox()),
        const SizedBox(width: 24),
        Expanded(
          child: _buildPodiumItem(
            context: context,
            entry: first,
            rank: 1,
            height: 280,
            accentColor: const Color(0xFFFFD700), // Gold
            icon: Icons.workspace_premium,
            isWinner: true,
          ),
        ),
        const SizedBox(width: 24),
        if (third != null)
          Expanded(
            child: _buildPodiumItem(
              context: context,
              entry: third,
              rank: 3,
              height: 190,
              accentColor: const Color(0xFFCD7F32), // Bronze
              icon: Icons.workspace_premium,
            ),
          )
        else
          const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _buildPodiumItem({
    required BuildContext context,
    required LeaderboardEntry entry,
    required int rank,
    required double height,
    required Color accentColor,
    required IconData icon,
    bool isWinner = false,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: accentColor,
                  width: isWinner ? 4 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: isWinner ? 54 : 42,
                backgroundImage: NetworkImage(entry.staff.avatar),
                backgroundColor: NeutralColors.border,
              ),
            ),
            Positioned(
              bottom: -10,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: isWinner ? 24 : 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                NeutralColors.surface,
                NeutralColors.surface.withValues(alpha: 0.8),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: NeutralColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                '#$rank',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                entry.staff.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TextColors.primary,
                  fontSize: isWinner ? 18 : 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              const Spacer(),
              Text(
                '\$${entry.revenue.toStringAsFixed(0)}',
                style: TextStyle(
                  color: PrimaryColors.brandGreen,
                  fontSize: isWinner ? 28 : 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '${entry.ordersCount} Orders',
                style: const TextStyle(
                  color: TextColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
