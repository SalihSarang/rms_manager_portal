import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_details_screen/menu_add_ons/components/menu_add_ons_header.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_details_screen/menu_add_ons/components/menu_add_ons_row.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';

class MenuAddOns extends StatelessWidget {
  final List<AddOnsModel> addOns;

  const MenuAddOns({super.key, required this.addOns});

  @override
  Widget build(BuildContext context) {
    if (addOns.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add-ons',
          style: TextStyle(
            color: TextColors.primary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: NeutralColors.border.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: NeutralColors.shadow.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header Row
              const MenuAddOnsHeader(),
              Divider(
                color: NeutralColors.border.withValues(alpha: 0.5),
                height: 1,
              ),
              // Data Rows
              ...addOns.map(
                (a) => MenuAddOnsRow(addOn: a, isLast: addOns.last == a),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
