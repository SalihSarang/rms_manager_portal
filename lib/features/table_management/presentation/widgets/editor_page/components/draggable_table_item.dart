// components/draggable_table_item.dart
// Makes a TableWidget draggable on the canvas.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../../cubit/table_editor_cubit.dart';
import '../../../cubit/table_editor_state.dart';
import '../../table_widget.dart';

class DraggableTableItem extends StatelessWidget {
  final TableModel table;
  final FocusNode focusNode;
  final ValueNotifier<TableModel?> draggingTableNotifier;
  final bool readOnly;

  const DraggableTableItem({
    super.key,
    required this.table,
    required this.focusNode,
    required this.draggingTableNotifier,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableEditorCubit, TableEditorState>(
      buildWhen: (prev, curr) {
        final wasSelected = prev.selectedTable?.id == table.id;
        final isSelected = curr.selectedTable?.id == table.id;
        final posChanged =
            prev.tables.firstWhere(
              (t) => t.id == table.id,
              orElse: () => table,
            ) !=
            curr.tables.firstWhere(
              (t) => t.id == table.id,
              orElse: () => table,
            );
        return wasSelected != isSelected || posChanged;
      },
      builder: (context, state) {
        final current = state.tables.firstWhere(
          (t) => t.id == table.id,
          orElse: () => table,
        );
        final isSelected = state.selectedTable?.id == table.id;
        final cubit = context.read<TableEditorCubit>();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            /// Placed table
            Positioned(
              key: ValueKey(table.id),
              left: current.x,
              top: current.y,
              child: ValueListenableBuilder<TableModel?>(
                valueListenable: draggingTableNotifier,
                builder: (_, dragging, child) {
                  final hidden = dragging?.id == table.id;
                  return Opacity(opacity: hidden ? 0.0 : 1.0, child: child);
                },
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    focusNode.requestFocus();
                    cubit.selectTable(table);
                  },
                  onScaleStart: readOnly
                      ? null
                      : (_) {
                          draggingTableNotifier.value = current;
                          cubit.selectTable(current);
                        },
                  onScaleUpdate: readOnly
                      ? null
                      : (details) {
                          final dragging = draggingTableNotifier.value;
                          if (dragging == null || dragging.id != table.id) {
                            return;
                          }
                          const hallWidth = 4000.0;
                          const hallHeight = 3000.0;
                          final newX = (dragging.x + details.focalPointDelta.dx)
                              .clamp(0.0, hallWidth - dragging.width);
                          final newY = (dragging.y + details.focalPointDelta.dy)
                              .clamp(0.0, hallHeight - dragging.height);
                          draggingTableNotifier.value = dragging.copyWith(
                            x: newX,
                            y: newY,
                          );
                        },
                  onScaleEnd: readOnly
                      ? null
                      : (_) {
                          final dragging = draggingTableNotifier.value;
                          if (dragging != null && dragging.id == table.id) {
                            cubit.updateTable(dragging);
                            draggingTableNotifier.value = null;
                          }
                        },
                  child: RepaintBoundary(
                    child: TableWidget(table: current, isSelected: isSelected),
                  ),
                ),
              ),
            ),

            /// Drag preview overlay
            Positioned(
              left: 0,
              top: 0,
              child: ValueListenableBuilder<TableModel?>(
                valueListenable: draggingTableNotifier,
                builder: (_, dragging, _) {
                  if (dragging == null || dragging.id != table.id) {
                    return const SizedBox.shrink();
                  }
                  return Transform.translate(
                    offset: Offset(dragging.x, dragging.y),
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: 0.8,
                        child: RepaintBoundary(
                          child: TableWidget(table: dragging, isSelected: true),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
