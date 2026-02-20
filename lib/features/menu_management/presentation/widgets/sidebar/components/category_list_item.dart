import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_event.dart';

class CategoryListItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;

  const CategoryListItem({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimaryColors.defaultColor.withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isSelected
            ? Border.all(
                color: PrimaryColors.defaultColor.withValues(alpha: 0.2),
              )
            : Border.all(color: Colors.transparent),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: isSelected
                    ? PrimaryColors.defaultColor
                    : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                horizontalTitleGap: 8,
                minLeadingWidth: 20,
                leading: const Icon(
                  Icons.drag_indicator,
                  color: NeutralColors.icon,
                  size: 20,
                ),
                title: Text(
                  category.name,
                  style: TextStyle(
                    color: isSelected
                        ? TextColors.inverse
                        : TextColors.inverse.withValues(alpha: 0.7),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                subtitle: const Text(
                  '0 items',
                  style: TextStyle(color: TextColors.secondary, fontSize: 13),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: TextColors.secondary,
                    size: 20,
                  ),
                ),
                selected: isSelected,
                splashColor: Colors.transparent,
                hoverColor: TextColors.inverse.withValues(alpha: 0.02),
                onTap: () {
                  context.read<MenuManagementBloc>().add(
                    SelectCategory(category.id),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
