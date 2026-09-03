import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/appbar/components/menu_appbar_actions.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/appbar/components/menu_appbar_search.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/appbar/components/menu_appbar_title.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class MenuAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddCategoryPressed;
  final VoidCallback onAddItemPressed;

  const MenuAppbar({
    super.key,
    required this.onAddCategoryPressed,
    required this.onAddItemPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isCompact = width <= 1100;
    final bool isIconOnly = width < 900;

    final double titleSize = isCompact ? 18 : 25;
    final double buttonHeight = isCompact ? 40 : 44;
    final double buttonWidth = isIconOnly ? 44 : (isCompact ? 130 : 150);

    final double sideSpacing = isCompact ? 10 : 20;

    return AppBar(
      backgroundColor: NeutralColors.background,
      toolbarHeight: 100,
      titleSpacing: sideSpacing,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: NeutralColors.border, height: 1.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          MenuAppbarTitle(titleSize: titleSize),

          // Search Bar (Hidden on very small screens, or scaled)
          if (width > 700) const MenuAppbarSearch(),

          // Actions
          MenuAppbarActions(
            onAddCategoryPressed: onAddCategoryPressed,
            onAddItemPressed: onAddItemPressed,
            isIconOnly: isIconOnly,
            buttonHeight: buttonHeight,
            buttonWidth: buttonWidth,
          ),
        ],
      ),
    );
  }
}
