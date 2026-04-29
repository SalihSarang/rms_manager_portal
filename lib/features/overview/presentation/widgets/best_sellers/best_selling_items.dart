import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/presentation/page/best_selling_items_report_page.dart';
import 'package:rms_design_system/rms_design_system.dart';

class BestSellingItems extends StatelessWidget {
  final List<BestSellerEntry> entries;

  const BestSellingItems({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Best-Selling Items',
                style: TextStyle(
                  color: TextColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BestSellingItemsReportPage(entries: entries),
                    ),
                  );
                },
                child: const Text(
                  'Full Report',
                  style: TextStyle(color: PrimaryColors.defaultColor, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Item Name',
                  style: TextStyle(color: TextColors.muted, fontSize: 12),
                ),
              ),
              const Expanded(
                child: Text(
                  'Qty Sold',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: TextColors.muted, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  'Revenue',
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: TextColors.muted, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: NeutralColors.border),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: entries.length > 5 ? 5 : entries.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: NeutralColors.transparent),
            ),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      entry.food.name,
                      style: const TextStyle(
                        color: TextColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${entry.quantitySold}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: TextColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '\$${entry.revenue.toStringAsFixed(2)}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: TextColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
