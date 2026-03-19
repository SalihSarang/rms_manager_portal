// components/sidebar/properties_panel.dart
// Panel shown in the sidebar when a table is selected.
import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'components/properties_header.dart';
import 'components/table_name_field.dart';
import 'components/table_position_display.dart';
import 'components/table_seat_counter.dart';
import 'components/table_delete_button.dart';

class PropertiesPanel extends StatelessWidget {
  final TableModel selectedTable;
  final TableEditorBloc bloc;

  const PropertiesPanel({
    super.key,
    required this.selectedTable,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: NeutralColors.surface,
        border: Border(
          top: BorderSide(color: NeutralColors.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PropertiesHeader(),
          TableNameField(table: selectedTable, bloc: bloc),
          TablePositionDisplay(table: selectedTable),
          TableSeatCounter(table: selectedTable, bloc: bloc),
          TableDeleteButton(tableId: selectedTable.id, bloc: bloc),
        ],
      ),
    );
  }
}
