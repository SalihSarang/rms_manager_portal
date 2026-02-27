import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffDetailsCardHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const StaffDetailsCardHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: PrimaryColors.defaultColor, size: 17),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: TextColors.inverse,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
