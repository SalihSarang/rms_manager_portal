import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class BestSellingItemsEmptyState extends StatelessWidget {
  const BestSellingItemsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: NeutralColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: NeutralColors.border),
            ),
            child: Icon(
              Icons.restaurant_menu_outlined,
              size: 64,
              color: PrimaryColors.defaultColor.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Sales Data Yet',
            style: TextStyle(
              color: TextColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Once items are sold, they will appear here ranked by popularity.',
            style: TextStyle(
              color: TextColors.secondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
