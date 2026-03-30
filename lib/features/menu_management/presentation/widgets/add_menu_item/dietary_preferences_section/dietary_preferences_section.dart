import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/dietary_preferences_section/components/dietary_tags_selector.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/dietary_preferences_section/components/visibility_status_toggles.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

/// [DietaryPreferencesSection] allows for capturing food dietary tags and status toggles.
/// It organizes selection tools for Veg/Non-Veg preferences and visibility features.
class DietaryPreferencesSection extends StatelessWidget {
  const DietaryPreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dietary & Preferences',
            style: TextStyle(
              color: NeutralColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: DietaryTagsSelector()),
              Expanded(child: VisibilityStatusToggles()),
            ],
          ),
        ],
      ),
    );
  }
}
