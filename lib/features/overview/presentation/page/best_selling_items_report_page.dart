import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/presentation/widgets/best_sellers/best_selling_items_empty_state.dart';
import 'package:manager_portal/features/overview/presentation/widgets/best_sellers/best_selling_items_report_content.dart';
import 'package:rms_design_system/rms_design_system.dart';

class BestSellingItemsReportPage extends StatelessWidget {
  final List<BestSellerEntry> entries;

  const BestSellingItemsReportPage({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: AppBar(
        backgroundColor: NeutralColors.surface,
        elevation: 0,
        title: const Text(
          'Best-Selling Items Report',
          style: TextStyle(
            color: TextColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: TextColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        shape: const Border(bottom: BorderSide(color: NeutralColors.border)),
      ),
      body: entries.isEmpty
          ? const BestSellingItemsEmptyState()
          : BestSellingItemsReportContent(entries: entries),
    );
  }
}
