import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class RmsDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const RmsDetailAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NeutralColors.surface,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: TextColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: TextColors.primary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      shape: const Border(bottom: BorderSide(color: NeutralColors.border)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
