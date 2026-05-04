import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isLast;

  const SettingsListTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PrimaryColors.defaultColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: PrimaryColors.defaultColor,
              size: 20,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: TextColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: const TextStyle(
                    color: TextColors.secondary,
                    fontSize: 12,
                  ),
                )
              : null,
          trailing: trailing ??
              (onTap != null
                  ? const Icon(
                      Icons.chevron_right,
                      color: TextColors.secondary,
                      size: 20,
                    )
                  : null),
        ),
        if (!isLast)
          const Divider(
            color: NeutralColors.border,
            indent: 56,
            height: 1,
          ),
      ],
    );
  }
}
