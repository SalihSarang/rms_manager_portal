import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

class PortionsAndPricingSection extends StatefulWidget {
  const PortionsAndPricingSection({super.key});

  @override
  State<PortionsAndPricingSection> createState() =>
      _PortionsAndPricingSectionState();
}

class _PortionsAndPricingSectionState extends State<PortionsAndPricingSection> {
  void _showAddPortionDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final countController = TextEditingController(); // Added
    final unitController = TextEditingController(); // Added
    final bloc = context.read<AddMenuItemBloc>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: NeutralColors.surface,
          title: const Text(
            'Add Portion',
            style: TextStyle(color: TextColors.inverse),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Portion Name',
                style: TextStyle(color: TextColors.secondary, fontSize: 14),
              ),
              const SizedBox(height: 8),
              PrimaryTextField(
                controller: nameController,
                hintText: 'e.g. Large',
              ),
              const SizedBox(height: 16),
              const Text(
                'Price (\$)',
                style: TextStyle(color: TextColors.secondary, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: priceController,
                style: const TextStyle(color: TextColors.inverse),
                decoration: InputDecoration(
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    color: TextColors.secondary.withValues(alpha: 0.5),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: NeutralColors.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: NeutralColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: NeutralColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: PrimaryColors.defaultColor,
                    ),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantity / Count',
                          style: TextStyle(
                            color: TextColors.secondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        PrimaryTextField(
                          controller: countController,
                          hintText: 'e.g. 500, 8, 1',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Unit',
                          style: TextStyle(
                            color: TextColors.secondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        PrimaryTextField(
                          controller: unitController,
                          hintText: 'e.g. grams, pieces',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: TextColors.secondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColors.defaultColor,
              ),
              onPressed: () {
                final newPortion = PortionAndPrice(
                  name: nameController.text.trim(),
                  price: double.tryParse(priceController.text) ?? 0,
                  count: int.tryParse(countController.text),
                  unit: unitController.text.trim().isEmpty
                      ? null
                      : unitController.text.trim(),
                );

                if (newPortion.name.isNotEmpty) {
                  bloc.add(PortionAdded(newPortion));
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: NeutralColors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _removePortion(int index) {
    context.read<AddMenuItemBloc>().add(PortionRemoved(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
      buildWhen: (previous, current) => previous.portions != current.portions,
      builder: (context, state) {
        final portions = state.portions;

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
                      'Portions & Pricing',
                      style: TextStyle(
                        color: NeutralColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _showAddPortionDialog,
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
              Container(
                color: NeutralColors.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Portion Name',
                        style: TextStyle(
                          color: TextColors.secondary.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Price (\$)',
                        style: TextStyle(
                          color: TextColors.secondary.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Count',
                        style: TextStyle(
                          color: TextColors.secondary.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const SizedBox(
                      width: 60,
                      child: Text(
                        'Actions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TextColors.secondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: NeutralColors.border),
              // Table Rows
              if (portions.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      'No portions added yet.',
                      style: TextStyle(color: TextColors.secondary),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: portions.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: NeutralColors.border),
                  itemBuilder: (context, index) {
                    final item = portions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                color: TextColors.secondary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.price.toStringAsFixed(2),
                              style: const TextStyle(
                                color: TextColors.secondary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${item.count ?? ''} ${item.unit ?? ''}'.trim(),
                              style: const TextStyle(
                                color: TextColors.secondary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 60,
                            child: IconButton(
                              onPressed: () => _removePortion(index),
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 20,
                                color: TextColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
