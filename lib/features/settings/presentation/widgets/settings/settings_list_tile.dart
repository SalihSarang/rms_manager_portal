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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: PrimaryColors.defaultColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: PrimaryColors.defaultColor, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: TextColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: subtitle != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    subtitle!,
                    style: TextStyle(
                      color: TextColors.secondary.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                  ),
                )
              : null,
          trailing:
              trailing ??
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
            indent: 72,
            endIndent: 16,
            height: 1,
          ),
      ],
    );
  }
}
