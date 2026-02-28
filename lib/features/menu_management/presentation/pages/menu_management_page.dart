import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/appbar/menu_appbar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/dialogs/add_category_dialog.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/sidebar/categories_sidebar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/menu_items_view.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:manager_portal/features/menu_management/presentation/pages/add_menu_item_page.dart';

class MenuManagementPage extends StatelessWidget {
  const MenuManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddCategoryBloc>()..add(LoadCategories()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: NeutralColors.background,
            appBar: MenuAppbar(
              onAddCategoryPressed: () {
                final bloc = context.read<AddCategoryBloc>();
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: const AddCategoryDialog(),
                  ),
                );
              },
              onAddItemPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AddMenuItemPage()),
                );
              },
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CategoriesSidebar(),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: MenuItemsView(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
