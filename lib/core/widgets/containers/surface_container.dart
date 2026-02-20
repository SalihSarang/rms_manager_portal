import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';

class SurfaceContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool hasBorder;
  final Color? backgroundColor;
  final double borderRadius;

  const SurfaceContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.isSelected = false,
    this.onTap,
    this.hasBorder = true,
    this.backgroundColor,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final container = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: padding,
      decoration: BoxDecoration(
        color: isSelected
            ? PrimaryColors.defaultColor.withValues(alpha: 0.15)
            : (backgroundColor ?? NeutralColors.surface),
        borderRadius: BorderRadius.circular(borderRadius),
        border: (isSelected || !hasBorder)
            ? null
            : Border.all(color: NeutralColors.border),
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}
