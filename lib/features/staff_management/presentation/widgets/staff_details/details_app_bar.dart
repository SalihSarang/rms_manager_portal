import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const StaffDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NeutralColors.background,
      toolbarHeight: 100,
      titleSpacing: 24,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: TextColors.inverse,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Staff Details',
            style: TextStyle(
              color: TextColors.inverse,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'View and verify all saved staff information.',
            style: TextStyle(color: TextColors.secondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
