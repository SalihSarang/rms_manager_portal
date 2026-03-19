import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import '../../../../cubit/table_editor_cubit.dart';

class TableDeleteButton extends StatelessWidget {
  final String tableId;
  final TableEditorCubit cubit;

  const TableDeleteButton({
    super.key,
    required this.tableId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: GestureDetector(
        onTap: () => cubit.deleteTable(tableId),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: SemanticColors.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: SemanticColors.error.withValues(alpha: 0.3),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_outline_rounded,
                  size: 17, color: SemanticColors.error),
              SizedBox(width: 8),
              const Text(
                'Delete Table',
                style: TextStyle(
                  color: SemanticColors.error,
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
