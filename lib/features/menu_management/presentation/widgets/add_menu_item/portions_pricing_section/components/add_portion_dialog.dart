import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manager_portal/core/widgets/inputs/primary_dropdown_field.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:manager_portal/features/menu_management/presentation/utils/validators.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

/// [AddPortionDialog] allows the user to input details for a new food portion.
/// It captures the serving name, its cost, and optional capacity metrics.
class AddPortionDialog extends StatefulWidget {
  /// Callback triggered when a new portion is successfully validated and added.
  final Function(PortionAndPrice) onAdd;

  const AddPortionDialog({super.key, required this.onAdd});

  @override
  State<AddPortionDialog> createState() => _AddPortionDialogState();
}

class _AddPortionDialogState extends State<AddPortionDialog> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final countController = TextEditingController();
  final unitController = TextEditingController();

  String? selectedUnit;
  final List<String> commonUnits = [
    'grams',
    'kg',
    'ml',
    'liters',
    'pieces',
    'portions',
    'bottles',
    'cans',
    'Other...',
  ];

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    countController.dispose();
    unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: NeutralColors.surface,
      title: const Text(
        'Add Portion',
        style: TextStyle(color: TextColors.primary),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Portion Name',
                style: TextStyle(color: TextColors.secondary, fontSize: 14),
              ),
              const SizedBox(height: 8),
              PrimaryTextField(
                controller: nameController,
                hintText: 'e.g. Large',
                validator: MenuValidators.validatePortionName,
              ),
              const SizedBox(height: 16),
              const Text(
                'Price (\$)',
                style: TextStyle(color: TextColors.secondary, fontSize: 14),
              ),
              const SizedBox(height: 8),
              PrimaryTextField(
                controller: priceController,
                hintText: '0.00',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: MenuValidators.validatePrice,
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: MenuValidators.validateCount,
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
                        PrimaryDropdownField<String>(
                          initialValue: selectedUnit,
                          hintText: 'Select Unit',
                          items: commonUnits
                              .map(
                                (unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedUnit = value;
                              if (value != 'Other...') {
                                unitController.text = value ?? '';
                              } else {
                                unitController.clear();
                              }
                            });
                          },
                          validator: (value) {
                            if (countController.text.isNotEmpty &&
                                (value == null)) {
                              return 'Unit required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (selectedUnit == 'Other...') ...[
                const SizedBox(height: 16),
                const Text(
                  'Custom Unit',
                  style: TextStyle(color: TextColors.secondary, fontSize: 14),
                ),
                const SizedBox(height: 8),
                PrimaryTextField(
                  controller: unitController,
                  hintText: 'e.g. ml, spoons',
                  validator: (value) {
                    final unitErr = MenuValidators.validateUnit(value);
                    if (unitErr != null) return unitErr;

                    if (countController.text.isNotEmpty &&
                        (value == null || value.trim().isEmpty)) {
                      return 'Unit required';
                    }
                    return null;
                  },
                ),
              ],
            ],
          ),
        ),
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
            if (_formKey.currentState!.validate()) {
              final newPortion = PortionAndPrice(
                name: nameController.text.trim(),
                price: double.tryParse(priceController.text) ?? 0,
                count: int.tryParse(countController.text),
                unit: unitController.text.trim().isEmpty
                    ? null
                    : unitController.text.trim(),
              );

              widget.onAdd(newPortion);
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            'Add',
            style: TextStyle(color: TextColors.primary),
          ),
        ),
      ],
    );
  }
}
