import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class TableManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const TableManagementAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NeutralColors.surface,
      elevation: 0,
      centerTitle: false,
      title: const Text(
        'Table Management',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 22,
          color: TextColors.primary,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
