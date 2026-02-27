import 'package:flutter/material.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/search_bar_container/components/dearchbar.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/search_bar_container/components/staff_filter_chips.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 900) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimarySearchBar(
                    width: double.infinity,
                    height: 40,
                    backgroundColor: NeutralColors.background,
                  ),
                  const SizedBox(height: 10),
                  StaffFilterChips(),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    child: PrimarySearchBar(
                      width: double.infinity,
                      height: 40,
                      backgroundColor: NeutralColors.background,
                    ),
                  ),
                  const SizedBox(width: 20),
                  StaffFilterChips(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
