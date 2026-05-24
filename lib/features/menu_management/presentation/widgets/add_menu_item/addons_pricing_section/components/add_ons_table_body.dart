import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/addons_pricing_section/components/add_on_table_row.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';

/// [AddOnsTableBody] renders the list of add-ons or an empty state message.
/// It uses [ListView.separated] to display [AddOnTableRow] components with dividers.
class AddOnsTableBody extends StatelessWidget {
  /// The collection of add-ons to display.
  final List<AddOnsModel> addOns;

  /// Callback executed when an add-on removal is requested at a specific index.
  final Function(int) onRemove;

  const AddOnsTableBody({
    super.key,
    required this.addOns,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (addOns.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'No add-ons added yet.',
            style: TextStyle(color: TextColors.secondary),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: addOns.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: NeutralColors.border),
      itemBuilder: (context, index) {
        return AddOnTableRow(
          addOn: addOns[index],
          onRemove: () => onRemove(index),
        );
      },
    );
  }
}
