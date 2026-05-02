import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class ReportsGridHeader extends StatelessWidget {
  const ReportsGridHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TABLE STATUS GRID',
          style: TextStyle(
            color: TextColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Real-time floor occupancy and server allocation',
          style: TextStyle(
            color: TextColors.secondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
