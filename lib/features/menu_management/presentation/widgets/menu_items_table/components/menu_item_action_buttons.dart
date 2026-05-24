import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [MenuItemActionButtons] manages the available actions for a food item row.
/// It currently supports "Edit" and toggling "Availability" (Mark Available/Sold Out).
class MenuItemActionButtons extends StatelessWidget {
  final bool isAvailable;
  final VoidCallback? onEdit;
  final VoidCallback? onToggleStatus;

  const MenuItemActionButtons({
    super.key,
    required this.isAvailable,
    required this.onEdit,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _ActionIconButton(
          icon: Icons.edit_outlined,
          onTap: onEdit,
          tooltip: 'Edit',
        ),
        const SizedBox(width: 4),
        _ActionIconButton(
          icon: isAvailable ? Icons.block : Icons.check_circle_outline,
          color: isAvailable ? SemanticColors.error : SemanticColors.success,
          onTap: onToggleStatus,
          tooltip: isAvailable ? 'Mark Sold Out' : 'Mark Available',
        ),
      ],
    );
  }
}

/// A specialized icon button for data table actions.
class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String tooltip;
  final Color? color;

  const _ActionIconButton({
    required this.icon,
    required this.tooltip,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 18, color: color ?? TextColors.secondary),
        ),
      ),
    );
  }
}
