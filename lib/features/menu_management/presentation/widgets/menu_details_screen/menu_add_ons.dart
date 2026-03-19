import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';

class MenuAddOns extends StatelessWidget {
  final List<AddOnsModel> addOns;

  const MenuAddOns({super.key, required this.addOns});

  @override
  Widget build(BuildContext context) {
    if (addOns.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add-ons',
          style: TextStyle(
            color: TextColors.inverse,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: NeutralColors.border.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addOns.length,
            separatorBuilder: (context, index) => Divider(
              color: NeutralColors.border.withValues(alpha: 0.5),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final a = addOns[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      a.name,
                      style: const TextStyle(
                        color: TextColors.inverse,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '+\$${a.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: TextColors.inverse,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
