import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:rms_design_system/rms_design_system.dart';

class FeaturedBestSellerCard extends StatelessWidget {
  final BestSellerEntry entry;
  final int rank;

  const FeaturedBestSellerCard({
    super.key,
    required this.entry,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final accentColors = [const Color(0xFFFFD700), const Color(0xFFC0C0C0), const Color(0xFFCD7F32)];
    final accentColor = accentColors[rank - 1];

    return Container(
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
              color: accentColor.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.trending_up_rounded,
              size: 100,
              color: accentColor.withValues(alpha: 0.05),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'RANK #$rank',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    if (rank == 1)
                      const Icon(
                        Icons.workspace_premium,
                        color: Color(0xFFFFD700),
                        size: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  entry.food.name,
                  style: const TextStyle(
                    color: TextColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  entry.food.category.name,
                  style: const TextStyle(
                    color: TextColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'UNITS SOLD',
                            style: TextStyle(
                              color: TextColors.muted,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${entry.quantitySold}',
                            style: const TextStyle(
                              color: TextColors.primary,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'REVENUE',
                            style: TextStyle(
                              color: TextColors.muted,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${entry.revenue.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: PrimaryColors.brandGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
