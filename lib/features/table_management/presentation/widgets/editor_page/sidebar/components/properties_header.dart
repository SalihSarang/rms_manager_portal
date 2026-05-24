import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class PropertiesHeader extends StatelessWidget {
  const PropertiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: PrimaryColors.defaultColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.tune_rounded,
              size: 16,
              color: PrimaryColors.defaultColor,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Properties',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: TextColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
