import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final Widget? icon;

  const PrimaryOutlinedButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
  }) : assert(
         label != null || icon != null,
         'Either label or icon must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: NeutralColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: label == null
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 24),
        backgroundColor: NeutralColors.surface,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ?icon,
          if (icon != null && label != null) const SizedBox(width: 8),
          if (label != null)
            Text(
              label!,
              style: const TextStyle(
                color: TextColors.inverse,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }
}
