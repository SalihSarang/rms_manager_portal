import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/appbar/menu_appbar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/dialogs/add_category_dialog.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/sidebar/categories_sidebar.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class MenuManagementPage extends StatelessWidget {
  const MenuManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: MenuAppbar(
        onAddCategoryPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddCategoryDialog(),
          );
        },
        onAddItemPressed: () {},
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CategoriesSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: NeutralColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: NeutralColors.border),
                ),
                child: const Center(
                  child: Text(
                    'Items list layout will go here.',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
