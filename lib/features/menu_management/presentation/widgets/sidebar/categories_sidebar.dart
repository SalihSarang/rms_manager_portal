import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_state.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/sidebar/components/category_list_item.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/sidebar/components/category_sidebar_header.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class CategoriesSidebar extends StatelessWidget {
  const CategoriesSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        border: const Border(right: BorderSide(color: NeutralColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategorySidebarHeader(),
          Expanded(
            child: BlocBuilder<MenuManagementBloc, MenuManagementState>(
              builder: (context, state) {
                if (state is MenuLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: TextColors.inverse),
                  );
                } else if (state is CategoriesLoaded) {
                  if (state.categories.isEmpty) {
                    return const Center(
                      child: Text(
                        'No categories found.',
                        style: TextStyle(color: TextColors.secondary),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      final isSelected =
                          category.id == state.selectedCategoryId;

                      return CategoryListItem(
                        category: category,
                        isSelected: isSelected,
                      );
                    },
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
                }

                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'No categories loaded.',
                      style: TextStyle(color: TextColors.secondary),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
