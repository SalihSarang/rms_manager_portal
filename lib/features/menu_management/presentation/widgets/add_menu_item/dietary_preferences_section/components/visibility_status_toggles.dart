import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/dietary_preferences_section/components/toggle_item_row.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [VisibilityStatusToggles] contains switches for global food item visibility and special behaviors.
/// It currently handles "Featured Item" status and "Allow Custom Notes" settings.
class VisibilityStatusToggles extends StatelessWidget {
  const VisibilityStatusToggles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visibility & Status',
          style: TextStyle(
            color: TextColors.secondary.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
          buildWhen: (p, c) => p.isFeatured != c.isFeatured,
          builder: (context, state) {
            return ToggleItemRow(
              label: 'Featured Item (Shows at top)',
              value: state.isFeatured,
              onChanged: (val) {
                context.read<AddMenuItemBloc>().add(
                      IsFeaturedChanged(val),
                    );
              },
            );
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
          buildWhen: (p, c) => p.isCustomNotes != c.isCustomNotes,
          builder: (context, state) {
            return ToggleItemRow(
              label: 'Allow Custom Notes',
              value: state.isCustomNotes,
              onChanged: (val) {
                context.read<AddMenuItemBloc>().add(
                      IsCustomNotesChanged(val),
                    );
              },
            );
          },
        ),
      ],
    );
  }
}
