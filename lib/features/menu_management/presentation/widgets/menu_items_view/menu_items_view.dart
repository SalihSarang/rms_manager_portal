import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/containers/surface_container.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/menu_items_table.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_header.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

/// Displays the list of food items for the currently selected category.
///
/// Handles various UI states including loading, error (with retry),
/// empty category, and the main table view.
class MenuItemsView extends StatelessWidget {
  /// Creates a [MenuItemsView].
  const MenuItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCategoryBloc, AddCategoryState>(
      builder: (context, state) {
        // --- State: Loading ---
        if (state is MenuLoading) {
          return const Center(
            child: CircularProgressIndicator(color: TextColors.inverse),
          );
        } else if (state is MenuError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: SemanticColors.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: SemanticColors.error,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<AddCategoryBloc>().add(const LoadCategories());
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 20),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SemanticColors.error.withValues(
                      alpha: 0.1,
                    ),
                    foregroundColor: SemanticColors.error,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is CategoriesLoaded && state.categories.isNotEmpty) {
          final selectedCategory = state.categories.firstWhere(
            (c) => c.id == state.selectedCategoryId,
            orElse: () => state.categories.first,
          );

          final items = state.foodItems;

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
                    child: state.isFoodLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: TextColors.inverse,
                            ),
                          )
                        : items.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant_menu_rounded,
                                  color: TextColors.secondary.withValues(
                                    alpha: 0.3,
                                  ),
                                  size: 64,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No items found in this category',
                                  style: TextStyle(
                                    color: TextColors.secondary.withValues(
                                      alpha: 0.7,
                                    ),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : MenuItemsTable(items: items),
                  ),
                ),
              ),
            ],
          );
        }

        return SurfaceContainer(
          borderRadius: 12,
          padding: EdgeInsets.zero,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.category_outlined,
                  color: TextColors.secondary.withValues(alpha: 0.3),
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select a category to view items',
                  style: TextStyle(color: TextColors.secondary),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
