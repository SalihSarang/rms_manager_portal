import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isEnabled;

  const AppBarIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isEnabled ? tooltip : 'Minimum zoom reached',
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: NeutralColors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isEnabled
                ? NeutralColors.icon
                : NeutralColors.icon.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
