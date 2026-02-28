import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class MenuItemsHeader extends StatelessWidget {
  final String categoryName;
  final int itemCount;

  const MenuItemsHeader({
    super.key,
    required this.categoryName,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryName,
                style: const TextStyle(
                  color: TextColors.inverse,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Managing $itemCount items in this category',
                style: const TextStyle(
                  color: TextColors.secondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        _HeaderActionButton(
          icon: Icons.filter_alt_outlined,
          onTap: () {},
          tooltip: 'Filter',
        ),
        const SizedBox(width: 8),
        _HeaderActionButton(
          icon: Icons.swap_vert,
          onTap: () {},
          tooltip: 'Sort',
        ),
      ],
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _HeaderActionButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: NeutralColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: TextColors.secondary, size: 18),
        ),
      ),
    );
  }
}
