import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/portions_pricing_section/components/add_portion_dialog.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/portions_pricing_section/components/portions_table_body.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/portions_pricing_section/components/portions_table_header.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [PortionsAndPricingSection] manages the distribution and pricing of food portions.
/// It provides an interface to define different serving sizes and their respective costs.
class PortionsAndPricingSection extends StatelessWidget {
  const PortionsAndPricingSection({super.key});

  void _showAddPortionDialog(BuildContext context) {
    final bloc = context.read<AddMenuItemBloc>();

    showDialog(
      context: context,
      builder: (context) {
        return AddPortionDialog(
          onAdd: (newPortion) {
            bloc.add(PortionAdded(newPortion));
          },
        );
      },
    );
  }

  void _removePortion(BuildContext context, int index) {
    context.read<AddMenuItemBloc>().add(PortionRemoved(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
      buildWhen: (previous, current) => previous.portions != current.portions,
      builder: (context, state) {
        final portions = state.portions;

        return FormField<bool>(
          validator: (value) {
            if (portions.isEmpty) {
              return 'You must add at least one portion';
            }
            return null;
          },
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: NeutralColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: field.hasError
                          ? SemanticColors.error
                          : NeutralColors.border,
                    ),
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
                            RichText(
                              text: const TextSpan(
                                text: 'Portions & Pricing ',
                                style: TextStyle(
                                  color: NeutralColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: SemanticColors.error,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => _showAddPortionDialog(context),
                              icon: const Icon(
                                Icons.add,
                                size: 16,
                                color: TextColors.secondary,
                              ),
                              label: const Text(
                                'Add Portion',
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
                      const PortionsTableHeader(),
                      const Divider(height: 1, color: NeutralColors.border),
                      // Table Body
                      PortionsTableBody(
                        portions: portions,
                        onRemove: (index) => _removePortion(context, index),
                      ),
                    ],
                  ),
                ),
                if (field.hasError) ...[
                  const SizedBox(height: 8),
                  Text(
                    field.errorText!,
                    style: const TextStyle(
                      color: SemanticColors.error,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }
}
