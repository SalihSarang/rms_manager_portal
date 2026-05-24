import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_state.dart';
import 'management_header.dart';
import 'hall_grid.dart';

class TableManagementLoadedView extends StatelessWidget {
  final TableEditorState state;

  const TableManagementLoadedView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ManagementHeader(
            hallCount: state.halls.length,
            totalTables: state.allTables.length,
          ),
          const SizedBox(height: 48),
          const Text(
            'Floor Sections',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: TextColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          HallGrid(state: state),
        ],
      ),
    );
  }
}
