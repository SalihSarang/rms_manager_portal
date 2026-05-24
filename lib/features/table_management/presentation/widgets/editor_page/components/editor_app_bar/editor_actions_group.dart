import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'app_bar_action_button.dart';

class EditorActionsGroup extends StatelessWidget {
  final bool readOnly;
  final VoidCallback? onEdit;

  const EditorActionsGroup({
    super.key,
    required this.readOnly,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (readOnly) {
      if (onEdit == null) return const SizedBox.shrink();
      return AppBarActionButton(
        icon: Icons.edit_location_alt_rounded,
        label: 'Edit Layout',
        onTap: onEdit!,
      );
    }

    return AppBarActionButton(
      icon: Icons.save_alt_rounded,
      label: 'Save',
      onTap: () {
        final bloc = context.read<TableEditorBloc>();
        final state = bloc.state;
        // In a real app, logic for saving to backend would go here.
        debugPrint('Tables: ${state.tables.length}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: TextColors.primary, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Layout saved!',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            backgroundColor: PrimaryColors.defaultColor,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
    );
  }
}
