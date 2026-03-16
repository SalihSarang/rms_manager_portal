import 'package:flutter/material.dart';
import 'package:manager_portal/features/table_management/presentation/widgets/table_widget.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';

/// A zoomable and scrollable view for arranging restaurant tables on a grid.
///
/// Uses [InteractiveViewer] to allow users to navigate a large floor plan
/// and [Draggable] to move tables around.
class TableLayoutView extends StatelessWidget {
  /// The list of tables to be displayed in the layout.
  final List<TableModel> tables;

  /// Creates a [TableLayoutView] with the given [tables].
  const TableLayoutView({super.key, required this.tables});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(500),
          minScale: 0.1,
          maxScale: 2.0,
          child: Stack(
            children: [
              // Background grid or floor plan (optional)
              Container(
                width: 2000,
                height: 2000,
                color: Colors.grey[200],
                child: CustomPaint(painter: GridPainter()),
              ),
              ...tables.map((table) {
                return Positioned(
                  left: table.posX,
                  top: table.posY,
                  child: Draggable(
                    feedback: Material(
                      color: Colors.transparent,
                      child: TableWidget(table: table, isFeedback: true),
                    ),
                    onDragUpdate: (details) {
                      // Optional: update position in real-time or wait for end
                    },
                    onDragEnd: (details) {
                      // Adjust position relative to the stack
                      /*
                      final RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      final localOffset = renderBox.globalToLocal(
                        details.offset,
                      );
                      */
                    },
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: TableWidget(table: table),
                    ),
                    child: TableWidget(table: table),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

/// A custom painter that renders a grid pattern for the table layout background.
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (double i = 0; i <= size.width; i += 50) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i <= size.height; i += 50) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
