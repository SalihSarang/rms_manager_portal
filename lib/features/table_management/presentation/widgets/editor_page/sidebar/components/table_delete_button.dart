import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_event.dart';

class TableDeleteButton extends StatelessWidget {
  final String tableId;
  final TableEditorBloc bloc;

  const TableDeleteButton({
    super.key,
    required this.tableId,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: GestureDetector(
        onTap: () => bloc.add(TableEditorTableDeleted(tableId)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: TableColors.destructive.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: TableColors.destructive.withValues(alpha: 0.3),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_outline_rounded,
                  size: 17, color: TableColors.destructive),
              SizedBox(width: 8),
              Text(
                'Delete Table',
                style: TextStyle(
                  color: TableColors.destructive,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
