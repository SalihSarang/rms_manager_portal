import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/containers/surface_container.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/menu_items_table.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_empty_view.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_header.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_loading_view.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

/// [MenuItemsContentView] is the primary layout for displaying a category's food items.
/// It renders the header, a toggle status row, and the main data table.
class MenuItemsContentView extends StatelessWidget {
  final String categoryName;
  final List<FoodModel> items;
  final bool isFoodLoading;

  const MenuItemsContentView({
    super.key,
    required this.categoryName,
    required this.items,
    required this.isFoodLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- Category Header ---
        Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
          child: MenuItemsHeader(
            categoryName: categoryName,
            itemCount: items.length,
          ),
        ),

        // --- Table Display ---
        Expanded(
          child: SurfaceContainer(
            borderRadius: 12,
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isFoodLoading
                  ? const MenuItemsLoadingView()
                  : items.isEmpty
                  ? const MenuItemsEmptyView(
                      icon: Icons.restaurant_menu_rounded,
                      label: 'No items found in this category',
                    )
                  : MenuItemsTable(items: items),
            ),
          ),
        ),
      ],
    );
  }
}
