import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/editor_page/table_layout_editor_ui.dart';
import '../bloc/table_editor_bloc/table_editor_bloc.dart';
import '../bloc/table_editor_bloc/table_editor_state.dart';
import '../bloc/table_editor_bloc/table_editor_event.dart';
import '../widgets/editor_page/utils/editor_ui_utils.dart';

/// Root page of the Table Layout Editor.
///
/// This page is now stateful to manage the lifecycle of controllers
/// (TransformationController, FocusNode) while keeping the UI layer stateless.
class TableLayoutEditorPage extends StatefulWidget {
  final VoidCallback onBack;
  final bool readOnly;
  final VoidCallback? onEdit;

  const TableLayoutEditorPage({
    super.key,
    required this.onBack,
    this.readOnly = false,
    this.onEdit,
  });

  @override
  State<TableLayoutEditorPage> createState() => _TableLayoutEditorPageState();
}

class _TableLayoutEditorPageState extends State<TableLayoutEditorPage> {
  late final TransformationController _transformationController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _focusNode = FocusNode();

    _transformationController.addListener(_onTransformationChanged);
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformationChanged);
    _transformationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTransformationChanged() {
    final bloc = context.read<TableEditorBloc>();
    EditorUiUtils.handleTransformationChanged(
      controller: _transformationController,
      currentScale: bloc.state.zoomScale,
      onScaleChanged: (scale) => bloc.add(TableEditorZoomUpdated(scale)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TableEditorBloc, TableEditorState>(
      listenWhen: (prev, curr) =>
          prev.viewportSize == null && curr.viewportSize != null,
      listener: (context, state) {
        // Center the canvas when the viewport size is first determined
        EditorUiUtils.centerCanvas(
          controller: _transformationController,
          viewportSize: state.viewportSize,
        );
      },
      child: TableLayoutEditorUI(
        onBack: widget.onBack,
        readOnly: widget.readOnly,
        onEdit: widget.onEdit,
        transformationController: _transformationController,
        focusNode: _focusNode,
      ),
    );
  }
}
