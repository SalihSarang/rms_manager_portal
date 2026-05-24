import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/portions_pricing_section/components/portion_table_row.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

/// [PortionsTableBody] renders the collection of defined portions.
/// It displays a list of [PortionTableRow] or an empty state message if no data exists.
class PortionsTableBody extends StatelessWidget {
  /// The list of portion and price models to display.
  final List<PortionAndPrice> portions;

  /// Triggered when a request to delete a portion at a specific [index] is made.
  final Function(int) onRemove;

  const PortionsTableBody({
    super.key,
    required this.portions,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (portions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'No portions added yet.',
            style: TextStyle(color: TextColors.secondary),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: portions.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: NeutralColors.border),
      itemBuilder: (context, index) {
        return PortionTableRow(
          portion: portions[index],
          onRemove: () => onRemove(index),
        );
      },
    );
  }
}
