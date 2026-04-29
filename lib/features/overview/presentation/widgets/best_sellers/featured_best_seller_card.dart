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
    final accentColors = [Colors.amber[600]!, Colors.grey[400]!, Colors.brown[400]!];
    final accentColor = accentColors[rank - 1];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Icon(
                Icons.star,
                color: rank == 1 ? Colors.amber : NeutralColors.border,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            entry.food.name,
            style: const TextStyle(
              color: TextColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sold',
                    style: TextStyle(color: TextColors.muted, fontSize: 12),
                  ),
                  Text(
                    '${entry.quantitySold}',
                    style: const TextStyle(
                      color: TextColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Revenue',
                    style: TextStyle(color: TextColors.muted, fontSize: 12),
                  ),
                  Text(
                    '\$${entry.revenue.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: PrimaryColors.brandGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
