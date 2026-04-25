import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class OverviewHeader extends StatelessWidget {
  const OverviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Executive Overview',
              style: TextStyle(
                color: TextColors.primary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: TextColors.muted,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Oct 24, 2024 - Oct 31, 2024',
                  style: TextStyle(color: TextColors.muted, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
