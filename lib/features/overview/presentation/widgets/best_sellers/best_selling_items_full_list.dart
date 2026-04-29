import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:rms_design_system/rms_design_system.dart';

class BestSellingItemsFullList extends StatelessWidget {
  final List<BestSellerEntry> restEntries;

  const BestSellingItemsFullList({super.key, required this.restEntries});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: restEntries.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final entry = restEntries[index];
        final rank = index + 4;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: NeutralColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: NeutralColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(color: NeutralColors.border),
                ),
                child: Center(
                  child: Text(
                    '$rank',
                    style: const TextStyle(
                      color: TextColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  entry.food.name,
                  style: const TextStyle(
                    color: TextColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${entry.quantitySold} Sold',
                    style: const TextStyle(
                      color: TextColors.primary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '\$${entry.revenue.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: PrimaryColors.brandGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
