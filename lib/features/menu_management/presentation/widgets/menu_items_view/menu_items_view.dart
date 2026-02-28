import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/containers/surface_container.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_state.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/menu_items_table.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_header.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class MenuItemsView extends StatelessWidget {
  const MenuItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuManagementBloc, MenuManagementState>(
      builder: (context, state) {
        if (state is MenuLoading) {
          return const Center(
            child: CircularProgressIndicator(color: TextColors.inverse),
          );
        } else if (state is MenuError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: SemanticColors.error),
              ),
            ),
          );
        } else if (state is CategoriesLoaded && state.categories.isNotEmpty) {
          final selectedCategory = state.categories.firstWhere(
            (c) => c.id == state.selectedCategoryId,
            orElse: () => state.categories.first,
          );

          // TODO: Fetch items based on category selection
          final items = <FoodModel>[];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                child: MenuItemsHeader(
                  categoryName: selectedCategory.name,
                  itemCount: items.length,
                ),
              ),
              Expanded(
                child: SurfaceContainer(
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: MenuItemsTable(items: items),
                  ),
                ),
              ),
            ],
          );
        }

        return const SurfaceContainer(
          borderRadius: 12,
          padding: EdgeInsets.zero,
          child: Center(
            child: Text(
              'Select a category to view items',
              style: TextStyle(color: TextColors.secondary),
            ),
          ),
        );
      },
    );
  }
}
