import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class OrderDetailsEmptyState extends StatelessWidget {
  const OrderDetailsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 64, color: TextColors.muted),
          SizedBox(height: 24),
          Text(
            'No active orders for this table.',
            style: TextStyle(
              color: TextColors.secondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
