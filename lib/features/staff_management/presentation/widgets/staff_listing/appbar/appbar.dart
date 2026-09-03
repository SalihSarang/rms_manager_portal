import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/primary_add_button.dart';
import 'package:manager_portal/core/widgets/responsive_layout.dart';
import 'package:manager_portal/core/widgets/secondery_add_button.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffManagementAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onAddPressed;

  const StaffManagementAppbar({super.key, required this.onAddPressed});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveLayout.isDesktop(context);

    final double titleSize = isDesktop ? 20 : 18;
    final double subtitleSize = isDesktop ? 14 : 12;
    final double buttonHeight = isDesktop ? 44 : 40;
    final double buttonWidth = isDesktop ? 180 : 44;

    final double sideSpacing = isDesktop ? 90 : 20;

    return AppBar(
      toolbarHeight: 100,
      titleSpacing: sideSpacing,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Staff Management', style: TextStyle(fontSize: titleSize)),
          const SizedBox(height: 2),
          Text(
            'Manage restaurant staff access, roles, and permissions.',
            style: TextStyle(
              fontSize: subtitleSize,
              color: TextColors.secondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: sideSpacing),
          child: SizedBox(
            height: buttonHeight,
            width: buttonWidth,
            child: isDesktop
                ? PrimaryAddButton(
                    icon: Icons.add,
                    label: 'Add New Staff',
                    height: buttonHeight,
                    width: buttonWidth,
                    onPressed: onAddPressed,
                  )
                : SeconderyAddButton(onAddPressed: onAddPressed),
          ),
        ),
      ],
    );
  }
}
