// components/editor_canvas.dart
// The interactive panning/zooming canvas where tables are placed.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../../bloc/table_editor_bloc.dart';
import '../../../bloc/table_editor_event.dart';
import '../../../bloc/table_editor_state.dart';
import '../../../painters/dot_grid_painter.dart';
import 'draggable_table_item.dart';

class EditorCanvas extends StatefulWidget {
  final TransformationController transformationController;
  final FocusNode focusNode;
  final bool readOnly;

  const EditorCanvas({
    super.key,
    required this.transformationController,
    required this.focusNode,
    this.readOnly = false,
  });

  @override
  State<EditorCanvas> createState() => _EditorCanvasState();
}

class _EditorCanvasState extends State<EditorCanvas> {
  final ValueNotifier<TableModel?> _draggingTableNotifier =
      ValueNotifier(null);

  @override
  void dispose() {
    _draggingTableNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableEditorBloc, TableEditorState>(
      builder: (context, state) {
        final bloc = context.read<TableEditorBloc>();
        return DragTarget<TableModel>(
          onAcceptWithDetails: widget.readOnly
              ? null
              : (details) {
                  final renderBox = context.findRenderObject() as RenderBox;
                  final localOffset = renderBox.globalToLocal(details.offset);
                  final matrix = widget.transformationController.value;
                  final invertedMatrix = Matrix4.inverted(matrix);
                  final transformedOffset = MatrixUtils.transformPoint(
                    invertedMatrix,
                    localOffset,
                  );

                  final template = details.data;
                  // Canvas represents a large restaurant hall (~16m × 12m at 1px=1cm)
                  const hallWidth = 1600.0;
                  const hallHeight = 1200.0;

                  final newX = (transformedOffset.dx - 50)
                      .clamp(0.0, hallWidth - template.width);
                  final newY = (transformedOffset.dy - 40)
                      .clamp(0.0, hallHeight - template.height);

                  final newTable = template.copyWith(
                    id: 'table_${DateTime.now().millisecondsSinceEpoch}',
                    name: 'T${state.tables.length + 1}',
                    x: newX,
                    y: newY,
                    hallId: state.selectedHall?.id ?? 'default',
                  );

                  bloc.add(TableEditorTableAdded(newTable));
                  widget.focusNode.requestFocus();
                },
          builder: (context, candidateData, rejectedData) {
            return ClipRect(
              child: Container(
                color: NeutralColors.background,
                child: GestureDetector(
                  onTap: () {
                    if (!widget.readOnly && state.mode == PlanMode.select) {
                      bloc.add(const TableEditorTableSelected(null));
                    }
                    widget.focusNode.requestFocus();
                  },
                  child: InteractiveViewer(
                    transformationController: widget.transformationController,
                    boundaryMargin: EdgeInsets.zero,
                    minScale: 0.4,
                    maxScale: 5.0,
                    constrained: true,
                    child: SizedBox(
                      // Canvas: realistic restaurant hall (~16m × 12m at 1px=1cm)
                      width: 1600,
                      height: 1200,
                      child: Stack(
                        children: [
                          // 1. Grid Background (inside IV so it pans with content)
                          const Positioned.fill(
                            child: RepaintBoundary(
                              child: CustomPaint(
                                painter: DotGridPainter(color: NeutralColors.border),
                              ),
                            ),
                          ),
                          // 2. Tables
                          if (state.tables.isNotEmpty)
                            ...state.tables.map(
                              (table) => DraggableTableItem(
                                key: ValueKey(table.id),
                                table: table,
                                focusNode: widget.focusNode,
                                draggingTableNotifier: _draggingTableNotifier,
                                readOnly: widget.readOnly,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
