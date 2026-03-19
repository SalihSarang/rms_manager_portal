// components/draggable_table_item.dart
// Makes a TableWidget draggable on the canvas.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../../cubit/table_editor_cubit.dart';
import '../../../cubit/table_editor_state.dart';
import '../../table_widget.dart';

/// A wrapper widget that provides dragging and selection capabilities to a [TableWidget].
///
/// This component handles:
/// 1. Positioning the table on the 2D canvas using [Positioned].
/// 2. Detecting gestures (tap to select, drag to move).
/// 3. Providing a visual "ghost" preview during active dragging.
/// 4. Updating the state via [TableEditorCubit] when a drag interaction ends.
class DraggableTableItem extends StatelessWidget {
  /// The table data associated with this item.
  final TableModel table;

  /// Focus node to manage keyboard/selection focus.
  final FocusNode focusNode;

  /// Notifier to track which table is currently being dragged across the layout.
  /// This allows for smooth "ghost" previews without triggering full rebuilds of all items.
  final ValueNotifier<TableModel?> draggingTableNotifier;

  /// Whether the editor is in preview-only mode (disables dragging).
  final bool readOnly;

  /// Creates a [DraggableTableItem].
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
        // Only rebuild if the selection status of THIS table changed,
        // or if its specific properties (like name or position) in the list changed.
        final wasSelected = prev.selectedTable?.id == table.id;
        final isSelected = curr.selectedTable?.id == table.id;
        final posChanged = prev.tables.firstWhere(
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
        // Extract current table data from state
        final current = state.tables.firstWhere(
          (t) => t.id == table.id,
          orElse: () => table,
        );
        final isSelected = state.selectedTable?.id == table.id;
        final cubit = context.read<TableEditorCubit>();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // ─── The Static / Placed Table ──────────────────────────
            // This is the version of the table that stays on the "grid"
            Positioned(
              key: ValueKey(table.id),
              left: current.x,
              top: current.y,
              child: ValueListenableBuilder<TableModel?>(
                valueListenable: draggingTableNotifier,
                builder: (_, dragging, child) {
                  // Hide the static table if it's currently being "lifted" and dragged elsewhere
                  final hidden = dragging?.id == table.id;
                  return Opacity(opacity: hidden ? 0.0 : 1.0, child: child);
                },
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    focusNode.requestFocus();
                    cubit.selectTable(table);
                  },
                  // Start drag: mark this table as the active dragging item
                  onScaleStart: readOnly
                      ? null
                      : (_) {
                          draggingTableNotifier.value = current;
                          cubit.selectTable(current);
                        },
                  // Update: move the "ghost" preview based on delta
                  onScaleUpdate: readOnly
                      ? null
                      : (details) {
                          final dragging = draggingTableNotifier.value;
                          if (dragging == null || dragging.id != table.id) {
                            return;
                          }
                          // Hardcoded constraints for the hall bounds (matches CanvasGrid)
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
                  // End drag: commit the new position to the BloC/database
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

            // ─── Drag Preview Overlay ─────────────────────────────
            // This "ghost" table follows the mouse perfectly during movement
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
