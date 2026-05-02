import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;

  const InfoTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: TextColors.muted,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(icon, size: 16, color: iconColor ?? TextColors.secondary),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                color: TextColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
