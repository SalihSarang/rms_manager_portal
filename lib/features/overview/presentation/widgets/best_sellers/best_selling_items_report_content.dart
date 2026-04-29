import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/presentation/widgets/best_sellers/best_selling_items_full_list.dart';
import 'package:manager_portal/features/overview/presentation/widgets/best_sellers/featured_best_seller_card.dart';
import 'package:rms_design_system/rms_design_system.dart';

class BestSellingItemsReportContent extends StatelessWidget {
  final List<BestSellerEntry> entries;

  const BestSellingItemsReportContent({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final top3 = entries.take(3).toList();
    final rest = entries.skip(3).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (top3.isNotEmpty) ...[
            const Text(
              'Top Performers',
              style: TextStyle(
                color: TextColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFeaturedGrid(top3),
          ],
          if (rest.isNotEmpty) ...[
            const SizedBox(height: 40),
            const Text(
              'All Menu Items',
              style: TextStyle(
                color: TextColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            BestSellingItemsFullList(restEntries: rest),
          ],
        ],
      ),
    );
  }

  Widget _buildFeaturedGrid(List<BestSellerEntry> top3) {
    return Row(
      children: top3.map((entry) {
        final index = top3.indexOf(entry);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index == 2 ? 0 : 24.0,
            ),
            child: FeaturedBestSellerCard(entry: entry, rank: index + 1),
          ),
        );
      }).toList(),
    );
  }
}
