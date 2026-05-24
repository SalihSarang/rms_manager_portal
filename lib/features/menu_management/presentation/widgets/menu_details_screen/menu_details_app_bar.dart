import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class MenuDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MenuDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NeutralColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: TextColors.primary,
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: NeutralColors.border.withValues(alpha: 0.5),
          height: 1.0,
        ),
      ),
      title: const RmsAppBarTitle('Item Details'),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
