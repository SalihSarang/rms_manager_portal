import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/sidebar/categories_sidebar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/menu_items_view.dart';

class MenuManagementBody extends StatelessWidget {
  const MenuManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CategoriesSidebar(),
        const Expanded(
          child: Padding(padding: EdgeInsets.all(20), child: MenuItemsView()),
        ),
      ],
    );
  }
}
