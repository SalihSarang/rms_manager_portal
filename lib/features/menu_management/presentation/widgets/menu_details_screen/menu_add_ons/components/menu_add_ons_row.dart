import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';

class MenuAddOnsRow extends StatelessWidget {
  final AddOnsModel addOn;
  final bool isLast;

  const MenuAddOnsRow({super.key, required this.addOn, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  addOn.name,
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  addOn.count?.toString() ?? '-',
                  style: const TextStyle(color: TextColors.secondary),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  addOn.unit ?? '-',
                  style: const TextStyle(color: TextColors.secondary),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '+\$${addOn.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            color: NeutralColors.border.withValues(alpha: 0.5),
            height: 1,
          ),
      ],
    );
  }
}
