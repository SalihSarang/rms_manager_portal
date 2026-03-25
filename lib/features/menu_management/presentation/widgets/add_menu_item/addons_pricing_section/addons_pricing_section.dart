import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/addons_pricing_section/components/add_add_on_dialog.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/addons_pricing_section/components/add_ons_table_body.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/addons_pricing_section/components/add_ons_table_header.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [AddOnsAndPricingSection] is a modular section for managing optional food add-ons.
/// It provides a table-like view to list, add, and remove add-ons.
class AddOnsAndPricingSection extends StatelessWidget {
  const AddOnsAndPricingSection({super.key});

  /// Launches a dialog to input and validate new add-on details.
  void _showAddAddOnDialog(BuildContext context) {
    final bloc = context.read<AddMenuItemBloc>();

    showDialog(
      context: context,
      builder: (context) {
        return AddAddOnDialog(
          onAdd: (newAddOn) {
            // Dispatches the new add-on to the Bloc state
            bloc.add(AddOnAdded(newAddOn));
          },
        );
      },
    );
  }

  /// Removes an add-on from the list at the specified [index].
  void _removeAddOn(BuildContext context, int index) {
    context.read<AddMenuItemBloc>().add(AddOnRemoved(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
      buildWhen: (previous, current) => previous.addOns != current.addOns,
      builder: (context, state) {
        final addOns = state.addOns;

        return Container(
          decoration: BoxDecoration(
            color: NeutralColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: NeutralColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add-ons & Pricing',
                      style: TextStyle(
                        color: NeutralColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _showAddAddOnDialog(context),
                      icon: const Icon(
                        Icons.add,
                        size: 16,
                        color: TextColors.secondary,
                      ),
                      label: const Text(
                        'Add new',
                        style: TextStyle(
                          color: TextColors.secondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Table Header
              const AddOnsTableHeader(),
              const Divider(height: 1, color: NeutralColors.border),
              // Table Body
              AddOnsTableBody(
                addOns: addOns,
                onRemove: (index) => _removeAddOn(context, index),
              ),
            ],
          ),
        );
      },
    );
  }
}
