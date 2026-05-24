import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class MenuDetailsAvailabilityBadge extends StatelessWidget {
  final bool isAvailable;

  const MenuDetailsAvailabilityBadge({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final color = isAvailable ? SemanticColors.success : SemanticColors.error;
    final text = isAvailable ? 'Available' : 'Sold Out';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
