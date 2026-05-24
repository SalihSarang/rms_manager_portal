import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/reusable_table.dart';
import 'package:manager_portal/features/menu_management/presentation/cubit/menu_items_pagination_cubit.dart';
import 'package:manager_portal/features/menu_management/presentation/pages/add_menu_item_page.dart';
import 'package:manager_portal/features/menu_management/presentation/pages/menu_details_screen.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_items_table_footer.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_items_table_row.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class MenuItemsTableContent extends StatelessWidget {
  final List<FoodModel> items;
  final int itemsPerPage;

  const MenuItemsTableContent({
    super.key,
    required this.items,
    required this.itemsPerPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemsPaginationCubit, int>(
      builder: (context, currentPage) {
        final totalItems = items.length;
        final totalPages = totalItems == 0
            ? 1
            : (totalItems / itemsPerPage).ceil();

        final cubit = context.read<MenuItemsPaginationCubit>();
        cubit.clampPage(totalPages);

        final safePage = (totalPages > 0 && currentPage > totalPages)
            ? totalPages
            : currentPage;
        final startIndex = (safePage - 1) * itemsPerPage;
        final endIndex = (startIndex + itemsPerPage < totalItems)
            ? startIndex + itemsPerPage
            : totalItems;

        final List<FoodModel> currentData = items.isEmpty
            ? []
            : items.sublist(startIndex, endIndex);

        return Column(
          children: [
            Expanded(
              child: ReusableTable<FoodModel>(
                data: currentData,
                columns: const [
                  DataColumn2(label: Text('#'), fixedWidth: 50),
                  DataColumn2(label: Text('Item'), size: ColumnSize.L),
                  DataColumn2(label: Text('Description'), size: ColumnSize.L),
                  DataColumn2(label: Text('Price')),
                  DataColumn2(label: Text('Status')),
                  DataColumn2(label: Text('Actions'), fixedWidth: 120),
                ],
                rowBuilder: (item) => MenuItemsTableRow(
                  index: startIndex + currentData.indexOf(item) + 1,
                  item: item,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuDetailsScreen(foodItem: item),
                      ),
                    );
                  },
                  onEdit: () async {
                    final bloc = context.read<AddCategoryBloc>();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddMenuItemPage(foodItemToEdit: item),
                      ),
                    );
                    if (bloc.state is CategoriesLoaded) {
                      final state = bloc.state as CategoriesLoaded;
                      bloc.add(
                        LoadCategories(
                          selectedCategoryId: state.selectedCategoryId,
                        ),
                      );
                    }
                  },
                  onToggleStatus: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          backgroundColor: NeutralColors.surface,
                          title: Text(
                            item.isAvailable
                                ? 'Mark Sold Out?'
                                : 'Mark Available?',
                            style: const TextStyle(color: Colors.white),
                          ),
                          content: Text(
                            'Are you sure you want to mark ${item.name} as ${item.isAvailable ? 'sold out' : 'available'}?',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                context.read<AddCategoryBloc>().add(
                                  ToggleFoodItemStatus(food: item),
                                );
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  color: item.isAvailable
                                      ? SemanticColors.error
                                      : SemanticColors.success,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            if (totalItems > itemsPerPage)
              MenuItemsTableFooter(
                startIndex: startIndex,
                endIndex: endIndex,
                totalItems: totalItems,
                currentPage: safePage,
                totalPages: totalPages,
                onPageChanged: (page) =>
                    context.read<MenuItemsPaginationCubit>().goToPage(page),
              ),
          ],
        );
      },
    );
  }
}
