// components/sidebar/sidebar.dart
// Main sidebar composing HallSelector, LibrarySection, and PropertiesPanel.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_state.dart';
import 'hall_selector.dart';
import 'properties_panel.dart';
import 'components/library_header.dart';
import 'components/library_guide_text.dart';
import 'components/table_library.dart';
import 'components/empty_selection_hint.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TableEditorBloc>();

    return Container(
      width: 288,
      decoration: const BoxDecoration(
        color: NeutralColors.surface,
        border: Border(right: BorderSide(color: NeutralColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HallSelector(),
          Container(
            height: 1,
            color: NeutralColors.border,
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
          const LibraryHeader(),
          const LibraryGuideText(),
          const TableLibrary(),

          /// Properties panel / Empty Hint
          BlocBuilder<TableEditorBloc, TableEditorState>(
            buildWhen: (p, c) => p.selectedTable != c.selectedTable,
            builder: (context, state) {
              if (state.selectedTable != null) {
                return PropertiesPanel(
                  selectedTable: state.selectedTable!,
                  bloc: bloc,
                );
              }
              return const EmptySelectionHint();
            },
          ),
        ],
      ),
    );
  }
}
