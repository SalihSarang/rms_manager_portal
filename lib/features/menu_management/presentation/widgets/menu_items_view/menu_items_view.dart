import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/containers/surface_container.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_content_view.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_empty_view.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_error_view.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_view/components/menu_items_loading_view.dart';

/// [MenuItemsView] is the main responsive view for displaying menu items.
/// It acts as a state switcher, handling Loading, Error, Empty, and Data states.
class MenuItemsView extends StatelessWidget {
  const MenuItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCategoryBloc, AddCategoryState>(
      builder: (context, state) {
        // --- State: Loading ---
        if (state is MenuLoading) {
          return const MenuItemsLoadingView();
        }

        // --- State: Error ---
        if (state is MenuError) {
          return MenuItemsErrorView(
            message: state.message,
            onRetry: () =>
                context.read<AddCategoryBloc>().add(const LoadCategories()),
          );
        }

        // --- State: Categories Loaded ---
        if (state is CategoriesLoaded && state.categories.isNotEmpty) {
          final selectedCategory = state.categories.firstWhere(
            (c) => c.id == state.selectedCategoryId,
            orElse: () => state.categories.first,
          );

          return MenuItemsContentView(
            categoryName: selectedCategory.name,
            items: state.foodItems,
            isFoodLoading: state.isFoodLoading,
          );
        }

        // --- State: Default (Initial or No Categories) ---
        final hasCategories =
            state is CategoriesLoaded && state.categories.isNotEmpty;

        return SurfaceContainer(
          borderRadius: 12,
          padding: EdgeInsets.zero,
          child: MenuItemsEmptyView(
            icon: Icons.category_outlined,
            label: hasCategories
                ? 'Select a category to view items'
                : 'No categories found.\nPlease create a category from the sidebar.',
          ),
        );
      },
    );
  }
}
