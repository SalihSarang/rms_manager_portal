import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffDetailsEmptyImagePlaceholder extends StatelessWidget {
  final String message;

  const StaffDetailsEmptyImagePlaceholder({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: NeutralColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_not_supported_outlined,
              color: NeutralColors.icon,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(color: TextColors.secondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
