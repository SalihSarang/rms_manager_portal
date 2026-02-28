import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

class PortionsAndPricingSection extends StatefulWidget {
  const PortionsAndPricingSection({super.key});

  @override
  State<PortionsAndPricingSection> createState() =>
      _PortionsAndPricingSectionState();
}

class _PortionsAndPricingSectionState extends State<PortionsAndPricingSection> {
  final List<PortionControllers> _controllers = [];

  @override
  void initState() {
    super.initState();
    final initialPortions = context.read<AddMenuItemBloc>().state.portions;
    for (var portion in initialPortions) {
      _controllers.add(PortionControllers.fromPortion(portion));
    }
    // If empty, add one default portion as per design?
    if (_controllers.isEmpty) {
      _addPortion();
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addPortion() {
    final newPortion = PortionAndPrice(name: '', price: 0);
    context.read<AddMenuItemBloc>().add(PortionAdded(newPortion));
    setState(() {
      _controllers.add(PortionControllers.fromPortion(newPortion));
    });
  }

  void _removePortion(int index) {
    context.read<AddMenuItemBloc>().add(PortionRemoved(index));
    setState(() {
      final c = _controllers.removeAt(index);
      c.dispose();
    });
  }

  void _updatePortion(int index) {
    final c = _controllers[index];
    final updatedPortion = PortionAndPrice(
      name: c.name.text,
      price: double.tryParse(c.price.text) ?? 0,
    );
    context.read<AddMenuItemBloc>().add(PortionUpdated(index, updatedPortion));
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
                'Portions & Pricing',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: _addPortion,
                icon: const Icon(
                  Icons.add,
                  size: 16,
                  color: TextColors.secondary,
                ),
                label: const Text(
                  'Add Portion',
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
                      hintText: 'e.g. Large',
                      onChanged: (_) => _updatePortion(index),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: PrimaryTextField(
                      controller: controllers.price,
                      hintText: '0.00',
                      onChanged: (_) => _updatePortion(index),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: PrimaryTextField(
                      controller: controllers.count,
                      hintText: '0',
                      onChanged: (_) => _updatePortion(index),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 60,
                    child: IconButton(
                      onPressed: () => _removePortion(index),
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

class PortionControllers {
  final TextEditingController name;
  final TextEditingController price;
  final TextEditingController count;

  PortionControllers({
    required this.name,
    required this.price,
    required this.count,
  });

  factory PortionControllers.fromPortion(PortionAndPrice portion) {
    return PortionControllers(
      name: TextEditingController(text: portion.name),
      price: TextEditingController(text: portion.price.toString()),
      count: TextEditingController(text: '0'), // Placeholder for UI count
    );
  }

  void dispose() {
    name.dispose();
    price.dispose();
    count.dispose();
  }
}
