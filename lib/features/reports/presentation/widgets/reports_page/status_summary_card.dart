import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StatusSummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color accentColor;
  final Color? iconColor;

  const StatusSummaryCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.accentColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: NeutralColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: NeutralColors.border.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: TextColors.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Icon(
                  icon,
                  color: iconColor ?? accentColor,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              count,
              style: const TextStyle(
                color: TextColors.primary,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Bottom accent bar
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
