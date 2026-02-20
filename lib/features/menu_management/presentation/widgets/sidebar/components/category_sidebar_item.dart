import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/containers/surface_container.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class CategorySidebarItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onEditPressed;

  const CategorySidebarItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: SurfaceContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        isSelected: isSelected,
        hasBorder: false,
        backgroundColor: Colors.transparent,
        onTap: () {
          // Temporarily removed BLoC action: context.read<MenuManagementBloc>().add(SelectCategory(category.id));
        },
        child: Row(
          children: [
            Icon(
              Icons.drag_indicator,
              size: 16,
              color: isSelected
                  ? PrimaryColors.defaultColor
                  : TextColors.inverse,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      color: isSelected
                          ? PrimaryColors.defaultColor
                          : TextColors.inverse,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: category.isActive
                          ? TextColors.secondary
                          : Colors.redAccent,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onEditPressed,
              icon: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: TextColors.inverse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
