import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [CategoryDropdown] allows for selecting a menu category.
/// It integrates with [AddCategoryBloc] to fetch available categories and
/// [AddMenuItemBloc] to update the selected category ID.
class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            color: NeutralColors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<AddCategoryBloc, AddCategoryState>(
          builder: (context, catState) {
            final categories = (catState is CategoriesLoaded)
                ? catState.categories
                : [];

            return BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
              buildWhen: (previous, current) =>
                  previous.category != current.category,
              builder: (context, state) {
                return DropdownButtonFormField<String>(
                  initialValue: state.category?.id,
                  dropdownColor: NeutralColors.surface,
                  style: const TextStyle(color: TextColors.inverse),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: NeutralColors.background,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: NeutralColors.border,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: NeutralColors.border,
                      ),
                    ),
                  ),
                  hint: Text(
                    catState is MenuLoading
                        ? 'Loading categories...'
                        : 'Select Category',
                    style: TextStyle(
                      color: TextColors.secondary.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                  items: categories.map<DropdownMenuItem<String>>((
                    cat,
                  ) {
                    return DropdownMenuItem<String>(
                      value: cat.id,
                      child: Text(cat.name),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      final selectedCat = categories.firstWhere(
                        (element) => element.id == val,
                      );
                      context.read<AddMenuItemBloc>().add(
                        CategoryChanged(selectedCat),
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
