import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';

class AddOnsAndPricingSection extends StatefulWidget {
  const AddOnsAndPricingSection({super.key});

  @override
  State<AddOnsAndPricingSection> createState() =>
      _AddOnsAndPricingSectionState();
}

class _AddOnsAndPricingSectionState extends State<AddOnsAndPricingSection> {
  final List<AddOnControllers> _controllers = [];

  @override
  void initState() {
    super.initState();
    final initialAddOns = context.read<AddMenuItemBloc>().state.addOns;
    for (var addOn in initialAddOns) {
      _controllers.add(AddOnControllers.fromAddOn(addOn));
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addAddOn() {
    final newAddOn = AddOnsModel(name: '', price: 0);
    context.read<AddMenuItemBloc>().add(AddOnAdded(newAddOn));
    setState(() {
      _controllers.add(AddOnControllers.fromAddOn(newAddOn));
    });
  }

  void _removeAddOn(int index) {
    context.read<AddMenuItemBloc>().add(AddOnRemoved(index));
    setState(() {
      final c = _controllers.removeAt(index);
      c.dispose();
    });
  }

  void _updateAddOn(int index) {
    final c = _controllers[index];
    final updatedAddOn = AddOnsModel(
      name: c.name.text,
      price: double.tryParse(c.price.text) ?? 0,
    );
    context.read<AddMenuItemBloc>().add(AddOnUpdated(index, updatedAddOn));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add-ons & Pricing',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: _addAddOn,
                icon: const Icon(
                  Icons.add,
                  size: 16,
                  color: TextColors.secondary,
                ),
                label: const Text(
                  'Add new',
                  style: TextStyle(color: TextColors.secondary, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_controllers.isNotEmpty)
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Add-ons Name',
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
                const Expanded(
                  flex: 1,
                  child: SizedBox(), //DESIGN PLACEHOLDER MATCHING Portions
                ),
                const SizedBox(width: 16),
                const SizedBox(
                  width: 60,
                  child: Text(
                    'Actions',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TextColors.secondary, fontSize: 12),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          ...List.generate(_controllers.length, (index) {
            final controllers = _controllers[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PrimaryTextField(
                      controller: controllers.name,
                      hintText: 'e.g. Extra Cheese',
                      onChanged: (_) => _updateAddOn(index),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: PrimaryTextField(
                      controller: controllers.price,
                      hintText: '0.00',
                      onChanged: (_) => _updateAddOn(index),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(flex: 1, child: SizedBox()),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 60,
                    child: IconButton(
                      onPressed: () => _removeAddOn(index),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: TextColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class AddOnControllers {
  final TextEditingController name;
  final TextEditingController price;

  AddOnControllers({required this.name, required this.price});

  factory AddOnControllers.fromAddOn(AddOnsModel addOn) {
    return AddOnControllers(
      name: TextEditingController(text: addOn.name),
      price: TextEditingController(text: addOn.price.toString()),
    );
  }

  void dispose() {
    name.dispose();
    price.dispose();
  }
}
