import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/reusable_table.dart';
import 'package:manager_portal/features/menu_management/presentation/cubit/menu_items_pagination_cubit.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_items_table_footer.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_items_table_row.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/utils/menu_items_table_handlers.dart';
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
                  onTap: () =>
                      MenuItemsTableHandlers.handleItemTap(context, item),
                  onEdit: () =>
                      MenuItemsTableHandlers.handleItemEdit(context, item),
                  onToggleStatus: () =>
                      MenuItemsTableHandlers.handleToggleStatus(context, item),
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
