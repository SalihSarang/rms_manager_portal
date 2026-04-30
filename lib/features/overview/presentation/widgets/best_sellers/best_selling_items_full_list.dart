import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:rms_design_system/rms_design_system.dart';

class BestSellingItemsFullList extends StatelessWidget {
  final List<BestSellerEntry> restEntries;

  const BestSellingItemsFullList({super.key, required this.restEntries});

  @override
  Widget build(BuildContext context) {
    // Find max quantity to calculate relative popularity bars
    final maxQty = restEntries.isNotEmpty 
        ? restEntries.map((e) => e.quantitySold).reduce((a, b) => a > b ? a : b)
        : 1;

    return Container(
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 1, color: NeutralColors.border),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restEntries.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: NeutralColors.border,
              indent: 24,
            ),
            itemBuilder: (context, index) {
              final entry = restEntries[index];
              final rank = index + 4;
              final popularity = entry.quantitySold / maxQty;

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '#$rank',
                        style: const TextStyle(
                          color: TextColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.food.name,
                            style: const TextStyle(
                              color: TextColors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.food.category.name,
                            style: const TextStyle(
                              color: TextColors.muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${entry.quantitySold} sold',
                                style: const TextStyle(
                                  color: TextColors.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${(popularity * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  color: TextColors.muted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: popularity,
                              backgroundColor: NeutralColors.background,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                PrimaryColors.defaultColor.withValues(alpha: 0.6),
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '\$${entry.revenue.toStringAsFixed(2)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: PrimaryColors.brandGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          SizedBox(width: 52),
          Expanded(
            flex: 4,
            child: Text(
              'ITEM DETAILS',
              style: TextStyle(
                color: TextColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'POPULARITY',
              style: TextStyle(
                color: TextColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          SizedBox(width: 32),
          Expanded(
            flex: 2,
            child: Text(
              'TOTAL REVENUE',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: TextColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
