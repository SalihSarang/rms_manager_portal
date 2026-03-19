import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import '../../../../cubit/table_editor_cubit.dart';
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
        final cubit = context.read<TableEditorCubit>();
        final state = cubit.state;
        // In a real app, logic for saving to backend would go here.
        debugPrint('Tables: ${state.tables.length}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: NeutralColors.white, size: 18),
                SizedBox(width: 8),
                Text('Layout saved!'),
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
