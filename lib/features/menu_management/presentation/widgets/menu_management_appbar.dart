import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/appbar/menu_appbar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/dialogs/add_category_dialog.dart';
import 'package:manager_portal/features/menu_management/presentation/pages/add_menu_item_page.dart';

class MenuManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MenuManagementAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAppbar(
      onAddCategoryPressed: () {
        final bloc = context.read<AddCategoryBloc>();
        showDialog(
          context: context,
          builder: (context) =>
              BlocProvider.value(value: bloc, child: const AddCategoryDialog()),
        );
      },
      onAddItemPressed: () async {
        final bloc = context.read<AddCategoryBloc>();
        await Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => AddMenuItemPage()));
        if (bloc.state is CategoriesLoaded) {
          final state = bloc.state as CategoriesLoaded;
          bloc.add(
            LoadCategories(selectedCategoryId: state.selectedCategoryId),
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
