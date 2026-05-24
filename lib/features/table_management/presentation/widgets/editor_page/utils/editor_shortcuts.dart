import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_event.dart';

class EditorShortcuts {
  static Map<ShortcutActivator, VoidCallback> getBindings(
    BuildContext context,
  ) {
    return {
      const SingleActivator(LogicalKeyboardKey.arrowUp): () => context
          .read<TableEditorBloc>()
          .add(const TableEditorTablePositionUpdated(dx: 0, dy: -10)),
      const SingleActivator(LogicalKeyboardKey.arrowDown): () => context
          .read<TableEditorBloc>()
          .add(const TableEditorTablePositionUpdated(dx: 0, dy: 10)),
      const SingleActivator(LogicalKeyboardKey.arrowLeft): () => context
          .read<TableEditorBloc>()
          .add(const TableEditorTablePositionUpdated(dx: -10, dy: 0)),
      const SingleActivator(LogicalKeyboardKey.arrowRight): () => context
          .read<TableEditorBloc>()
          .add(const TableEditorTablePositionUpdated(dx: 10, dy: 0)),
      const SingleActivator(LogicalKeyboardKey.delete): () {
        final bloc = context.read<TableEditorBloc>();
        final selected = bloc.state.selectedTable;
        if (selected != null) bloc.add(TableEditorTableDeleted(selected.id));
      },
      const SingleActivator(LogicalKeyboardKey.backspace): () {
        final bloc = context.read<TableEditorBloc>();
        final selected = bloc.state.selectedTable;
        if (selected != null) bloc.add(TableEditorTableDeleted(selected.id));
      },
    };
  }
}
