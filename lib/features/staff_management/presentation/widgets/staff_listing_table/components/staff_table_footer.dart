import 'package:flutter/material.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing_table/components/page_number_button.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing_table/components/pagination_button.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffTableFooter extends StatelessWidget {
  final int startIndex;
  final int endIndex;
  final int totalItems;
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const StaffTableFooter({
    super.key,
    required this.startIndex,
    required this.endIndex,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: NeutralColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${startIndex + 1} to $endIndex of $totalItems results',
            style: const TextStyle(color: TextColors.secondary, fontSize: 12),
          ),
          Row(
            children: [
              PaginationButton(
                text: "Previous",
                isEnabled: currentPage > 1,
                onTap: () => onPageChanged(currentPage - 1),
              ),
              const SizedBox(width: 8),
              ...List.generate(totalPages, (index) {
                final pageNumber = index + 1;
                return PageNumberButton(
                  pageNumber: pageNumber,
                  isSelected: pageNumber == currentPage,
                  onTap: () => onPageChanged(pageNumber),
                );
              }),
              PaginationButton(
                text: "Next",
                isEnabled: currentPage < totalPages,
                onTap: () => onPageChanged(currentPage + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
