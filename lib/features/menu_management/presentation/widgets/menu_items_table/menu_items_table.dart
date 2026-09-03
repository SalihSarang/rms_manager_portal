import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/cubit/menu_items_pagination_cubit.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/menu_items_table_content.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

/// A paginated table for displaying and managing a list of food items.
///
/// It encapsulates the pagination logic using [MenuItemsPaginationCubit]
/// and renders the [MenuItemsTableContent].
class MenuItemsTable extends StatelessWidget {
  /// The list of [FoodModel] items to display in the table.
  final List<FoodModel> items;

  /// Number of food items to display per page.
  static const int _itemsPerPage = 10;

  const MenuItemsTable({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MenuItemsPaginationCubit(),
      child: MenuItemsTableContent(items: items, itemsPerPage: _itemsPerPage),
    );
  }
}
