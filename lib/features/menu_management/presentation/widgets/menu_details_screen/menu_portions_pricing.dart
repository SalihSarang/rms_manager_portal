import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

class MenuPortionsPricing extends StatelessWidget {
  final List<PortionAndPrice> portions;

  const MenuPortionsPricing({super.key, required this.portions});

  @override
  Widget build(BuildContext context) {
    if (portions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Portions & Pricing',
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
            border: Border.all(
              color: NeutralColors.border.withValues(alpha: 0.5),
            ),
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
            itemCount: portions.length,
            separatorBuilder: (context, index) => Divider(
              color: NeutralColors.border.withValues(alpha: 0.5),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final p = portions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p.name,
                      style: const TextStyle(
                        color: TextColors.inverse,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$${p.price.toStringAsFixed(2)}',
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
