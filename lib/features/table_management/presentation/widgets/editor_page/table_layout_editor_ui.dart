import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_state.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'components/editor_app_bar.dart';
import 'components/editor_main_layout.dart';
import 'utils/editor_ui_utils.dart';

/// The user interface for the Table Layout Editor.
///
/// This widget coordinates the [EditorAppBar], [Sidebar], and [EditorCanvas].
/// It is now stateless, with state managed by [TableEditorBloc] and
/// controllers provided by the parent.
class TableLayoutEditorUI extends StatelessWidget {
  /// Callback when the back button is pressed.
  final VoidCallback onBack;

  /// Whether the editor is in read-only mode.
  final bool readOnly;

  /// Optional callback to switch to editing mode.
  final VoidCallback? onEdit;

  /// Controller for zooming and panning the canvas.
  final TransformationController transformationController;

  /// Focus node for handling keyboard shortcuts.
  final FocusNode focusNode;

  /// Creates a [TableLayoutEditorUI].
  const TableLayoutEditorUI({
    super.key,
    required this.onBack,
    required this.transformationController,
    required this.focusNode,
    this.readOnly = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<TableEditorBloc, TableEditorState>(
      listenWhen: (prev, curr) =>
          curr.error != null && prev.error != curr.error,
      listener: (context, state) {
        if (state.error != null) {
          RmsSnackbar.show(
            context,
            message: state.error!,
            type: RmsSnackbarType.error,
          );
        }
      },
      child: BlocBuilder<TableEditorBloc, TableEditorState>(
        buildWhen: (prev, curr) => prev.zoomScale != curr.zoomScale,
        builder: (context, state) {
          return Column(
            children: [
              EditorAppBar(
                onZoomIn: () => EditorUiUtils.zoomIn(transformationController),
                onZoomOut: () =>
                    EditorUiUtils.zoomOut(transformationController),
                isZoomOutEnabled: state.zoomScale > 1.0,
                zoomPercent: (state.zoomScale * 100).round(),
                onBack: onBack,
                readOnly: readOnly,
                onEdit: onEdit,
              ),
              EditorMainLayout(
                readOnly: readOnly,
                transformationController: transformationController,
                focusNode: focusNode,
              ),
            ],
          );
        },
      ),
    );
  }
}
