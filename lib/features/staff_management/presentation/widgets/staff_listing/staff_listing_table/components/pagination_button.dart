import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PaginationButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback onTap;

  const PaginationButton({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: NeutralColors.border),
            color: isEnabled
                ? null
                : NeutralColors.surface.withValues(alpha: 0.5),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isEnabled
                  ? TextColors.secondary
                  : TextColors.secondary.withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
