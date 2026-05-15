import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PayoutDialogHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const PayoutDialogHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: TextColors.primary,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: TextColors.secondary, fontSize: 14),
            ),
          ],
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close_rounded,
            color: TextColors.secondary.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
