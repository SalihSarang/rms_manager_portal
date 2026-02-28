import 'package:flutter/material.dart';

import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/menu_items_table.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class MenuItemsView extends StatelessWidget {
  final CategoryModel? category;
  final List<FoodModel> items;

  const MenuItemsView({super.key, required this.category, required this.items});

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return const Center(
        child: Text(
          'Select a category to view items',
          style: TextStyle(color: TextColors.secondary),
        ),
      );
    }

    return Column(
      children: [Expanded(child: MenuItemsTable(items: items))],
    );
  }
}
