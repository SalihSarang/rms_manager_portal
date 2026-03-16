import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_management_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/widgets/table_widget.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

/// A zoomable and scrollable view for arranging restaurant tables on a grid.
///
/// Uses [InteractiveViewer] to allow users to navigate a large floor plan.
/// In "Edit" mode (`isReadOnly: false`), tables can be dragged to new positions.
class TableLayoutView extends StatelessWidget {
  /// The list of tables to be displayed in the layout.
  final List<TableModel> tables;

  /// Whether the layout is in read-only mode.
  final bool isReadOnly;

  /// Creates a [TableLayoutView].
  const TableLayoutView({
    super.key,
    required this.tables,
    this.isReadOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(1000),
          minScale: 0.1,
          maxScale: 2.0,
          child: Stack(
            children: [
              // Background grid
              Container(
                width: 3000,
                height: 3000,
                color: const Color(0xFF161621), // Deeper dark for hall feel
                child: CustomPaint(painter: GridPainter()),
              ),
              ...tables.map((table) {
                return Positioned(
                  left: table.posX,
                  top: table.posY,
                  child: isReadOnly
                      ? TableWidget(table: table)
                      : LongPressDraggable<TableModel>(
                          data: table,
                          feedback: Material(
                            color: Colors.transparent,
                            child: TableWidget(table: table, isFeedback: true),
                          ),
                          onDragEnd: (details) {
                            // Adjust position relative to the stack using local coordinate system
                            final RenderBox renderBox = context.findRenderObject() as RenderBox;
                            final localOffset = renderBox.globalToLocal(details.offset);
                            
                            // Align to grid (snap to 40px grid)
                            final snappedX = (localOffset.dx / 40).round() * 40.0;
                            final snappedY = (localOffset.dy / 40).round() * 40.0;

                            context.read<TableManagementBloc>().add(
                                  UpdateTable(table.copyWith(
                                    posX: snappedX,
                                    posY: snappedY,
                                  )),
                                );
                          },
                          childWhenDragging: Opacity(
                            opacity: 0.3,
                            child: TableWidget(table: table),
                          ),
                          child: Tooltip(
                            message: 'Long press to drag',
                            child: TableWidget(table: table),
                          ),
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

/// A custom painter that renders a soft grid pattern for the table layout.
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = NeutralColors.border.withAlpha(15)
      ..strokeWidth = 1.0;

    const double step = 40.0;

    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
