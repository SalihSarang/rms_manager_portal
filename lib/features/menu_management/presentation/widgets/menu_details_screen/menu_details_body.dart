import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'menu_add_ons/menu_add_ons.dart';
import 'menu_details_description.dart';
import 'menu_details_header/menu_details_header.dart';
import 'menu_portions_pricing.dart';

class MenuDetailsBody extends StatelessWidget {
  final FoodModel item;

  const MenuDetailsBody({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuDetailsHeader(item: item),
              const SizedBox(height: 48),

              if (item.description.isNotEmpty) ...[
                MenuDetailsDescription(description: item.description),
                const SizedBox(height: 48),
              ],

              // Stacked Tables (Portions & Add-ons)
              if (item.portions.isNotEmpty) ...[
                MenuPortionsPricing(portions: item.portions),
                const SizedBox(height: 48),
              ],
              if (item.addOns.isNotEmpty) ...[MenuAddOns(addOns: item.addOns)],
              const SizedBox(height: 64), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
