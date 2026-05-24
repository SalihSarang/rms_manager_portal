import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/dietary_preferences_section/components/dietary_tag_item.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [DietaryTagsSelector] manages the Veg/Non-Veg preference selection.
/// It interacts with [AddMenuItemBloc] to update the boolean preference status.
class DietaryTagsSelector extends StatelessWidget {
  const DietaryTagsSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dietary Tags',
          style: TextStyle(
            color: TextColors.secondary.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
          buildWhen: (p, c) => p.isVeg != c.isVeg,
          builder: (context, state) {
            return Row(
              children: [
                DietaryTagItem(
                  label: 'Vegetarian',
                  isSelected: state.isVeg,
                  onTap: () {
                    context.read<AddMenuItemBloc>().add(IsVegChanged(true));
                  },
                ),
                const SizedBox(width: 12),
                DietaryTagItem(
                  label: 'Non-Vegetarian',
                  isSelected: !state.isVeg,
                  onTap: () {
                    context.read<AddMenuItemBloc>().add(IsVegChanged(false));
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
