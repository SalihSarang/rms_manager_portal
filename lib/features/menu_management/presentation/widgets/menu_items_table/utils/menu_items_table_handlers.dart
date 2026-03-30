import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:manager_portal/features/menu_management/presentation/pages/add_menu_item_page.dart';
import 'package:manager_portal/features/menu_management/presentation/pages/menu_details_screen.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/toggle_status_dialog.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class MenuItemsTableHandlers {
  static void handleItemTap(BuildContext context, FoodModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuDetailsScreen(foodItem: item),
      ),
    );
  }

  static Future<void> handleItemEdit(BuildContext context, FoodModel item) async {
    final bloc = context.read<AddCategoryBloc>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMenuItemPage(foodItemToEdit: item),
      ),
    );
    if (bloc.state is CategoriesLoaded) {
      final state = bloc.state as CategoriesLoaded;
      bloc.add(LoadCategories(selectedCategoryId: state.selectedCategoryId));
    }
  }

  static void handleToggleStatus(BuildContext context, FoodModel item) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ToggleStatusDialog(
          item: item,
          onConfirm: () {
            context.read<AddCategoryBloc>().add(ToggleFoodItemStatus(food: item));
          },
        );
      },
    );
  }
}
