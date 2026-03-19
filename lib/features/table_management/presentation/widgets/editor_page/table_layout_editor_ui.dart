import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/table_editor_cubit.dart';
import '../../cubit/table_editor_state.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'components/editor_app_bar.dart';
import 'sidebar/sidebar.dart';
import 'components/editor_canvas.dart';
import 'utils/transformation_manager.dart';

/// The user interface for the Table Layout Editor.
///
/// This widget coordinates the [EditorAppBar], [Sidebar], and [EditorCanvas].
/// It also handles keyboard shortcuts for moving tables and manages the
/// [TransformationController] for zooming and panning.
class TableLayoutEditorUI extends StatefulWidget {
  /// Callback when the back button is pressed.
  final VoidCallback onBack;

  /// Whether the editor is in read-only mode.
  final bool readOnly;

  /// Optional callback to switch to editing mode.
  final VoidCallback? onEdit;

  /// Creates a [TableLayoutEditorUI].
  const TableLayoutEditorUI({
    super.key,
    required this.onBack,
    this.readOnly = false,
    this.onEdit,
  });

  @override
  State<TableLayoutEditorUI> createState() => _TableLayoutEditorUIState();
}

class _TableLayoutEditorUIState extends State<TableLayoutEditorUI> {
  final TransformationController _transformationController =
      TransformationController();
  final FocusNode _focusNode = FocusNode();
  double _currentScale = 1.0;
  Size? _canvasViewportSize;

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(_handleTransformationChanged);
    // Center the canvas on first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _centerCanvas());
  }

  void _centerCanvas() {
    final size = _canvasViewportSize;
    if (size == null) return;
    
    TransformationManager.centerCanvas(
      controller: _transformationController,
      viewportSize: size,
    );
  }

  @override
  void dispose() {
    _transformationController.removeListener(_handleTransformationChanged);
    _transformationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTransformationChanged() {
    final scale = TransformationManager.getScale(_transformationController);
    if (scale != _currentScale) {
      setState(() {
        _currentScale = scale;
      });
    }
  }

  void _zoomIn() => TransformationManager.zoomIn(_transformationController);

  void _zoomOut() => TransformationManager.zoomOut(_transformationController);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TableEditorCubit, TableEditorState>(
      listenWhen: (prev, curr) => curr.error != null && prev.error != curr.error,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error!),
            backgroundColor: SemanticColors.error,
          ),
        );
      },
      child: Column(
        children: [
          EditorAppBar(
            onZoomIn: _zoomIn,
            onZoomOut: _zoomOut,
            isZoomOutEnabled: _currentScale > 1.0,
            zoomPercent: (_currentScale * 100).round(),
            onBack: widget.onBack,
            readOnly: widget.readOnly,
            onEdit: widget.onEdit,
          ),
          Expanded(
            child: Row(
              children: [
                if (!widget.readOnly) const Sidebar(),
                Expanded(
                  child: Stack(
                    children: [
                      ClipRect(
                        child: CallbackShortcuts(
                          bindings: widget.readOnly
                              ? {}
                              : {
                                  const SingleActivator(LogicalKeyboardKey.arrowUp): () =>
                                      context
                                          .read<TableEditorCubit>()
                                          .updateSelectedTablePosition(0, -10),
                                  const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
                                      context
                                          .read<TableEditorCubit>()
                                          .updateSelectedTablePosition(0, 10),
                                  const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
                                      context
                                          .read<TableEditorCubit>()
                                          .updateSelectedTablePosition(-10, 0),
                                  const SingleActivator(LogicalKeyboardKey.arrowRight):
                                      () => context
                                          .read<TableEditorCubit>()
                                          .updateSelectedTablePosition(10, 0),
                                  const SingleActivator(LogicalKeyboardKey.delete): () {
                                    final cubit = context.read<TableEditorCubit>();
                                    final selected = cubit.state.selectedTable;
                                    if (selected != null) cubit.deleteTable(selected.id);
                                  },
                                  const SingleActivator(LogicalKeyboardKey.backspace): () {
                                    final cubit = context.read<TableEditorCubit>();
                                    final selected = cubit.state.selectedTable;
                                    if (selected != null) cubit.deleteTable(selected.id);
                                  },
                                },
                          child: Focus(
                            autofocus: !widget.readOnly,
                            focusNode: _focusNode,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                _canvasViewportSize = Size(
                                  constraints.maxWidth,
                                  constraints.maxHeight,
                                );
                                return EditorCanvas(
                                  transformationController:
                                      _transformationController,
                                  focusNode: _focusNode,
                                  readOnly: widget.readOnly,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<TableEditorCubit, TableEditorState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: PrimaryColors.defaultColor,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
