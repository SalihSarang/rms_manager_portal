import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/containers/surface_container.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';

class SettingsSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 8.0),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: PrimaryColors.defaultColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SurfaceContainer(
          padding: EdgeInsets.zero,
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
