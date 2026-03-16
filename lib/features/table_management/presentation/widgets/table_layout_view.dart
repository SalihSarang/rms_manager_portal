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
    return DragTarget<TableModel>(
      onWillAcceptWithDetails: (details) => !isReadOnly,
      onAcceptWithDetails: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localOffset = renderBox.globalToLocal(details.offset);
        final snappedX = (localOffset.dx / 40).round() * 40.0;
        final snappedY = (localOffset.dy / 40).round() * 40.0;

        final newTable = details.data.copyWith(
          id:
              DateTime.now().millisecondsSinceEpoch %
              10000, // Better unique ID logic needed in repo
          name: 'T-${(tables.length + 1).toString().padLeft(2, '0')}',
          posX: snappedX,
          posY: snappedY,
        );

        context.read<TableManagementBloc>().add(AddTable(newTable));
      },
      builder: (context, candidateData, rejectedData) {
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

                  // Axis Labels Placeholder (20m, 15m labels from image)
                  _buildAxisLabel('20m', const Offset(400, 10)),
                  _buildAxisLabel('15m', const Offset(10, 300)),

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
                                child: TableWidget(
                                  table: table,
                                  isFeedback: true,
                                ),
                              ),
                              onDragEnd: (details) {
                                final RenderBox renderBox =
                                    context.findRenderObject() as RenderBox;
                                final localOffset = renderBox.globalToLocal(
                                  details.offset,
                                );

                                // Align to grid (snap to 40px grid)
                                final snappedX =
                                    (localOffset.dx / 40).round() * 40.0;
                                final snappedY =
                                    (localOffset.dy / 40).round() * 40.0;

                                context.read<TableManagementBloc>().add(
                                  UpdateTable(
                                    table.copyWith(
                                      posX: snappedX,
                                      posY: snappedY,
                                    ),
                                  ),
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
      },
    );
  }

  Widget _buildAxisLabel(String text, Offset position) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3C),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: NeutralColors.border.withAlpha(15)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// A custom painter that renders a soft grid pattern for the table layout.
/// Updated to match the dual-tone grid in the user's image.
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final subPaint = Paint()
      ..color = NeutralColors.border.withAlpha(8)
      ..strokeWidth = 0.5;

    final mainPaint = Paint()
      ..color = NeutralColors.border.withAlpha(20)
      ..strokeWidth = 1.0;

    const double subStep = 40.0;
    const double mainStep = 200.0;

    // Draw sub grid
    for (double i = 0; i < size.width; i += subStep) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), subPaint);
    }
    for (double i = 0; i < size.height; i += subStep) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), subPaint);
    }

    // Draw main grid
    for (double i = 0; i < size.width; i += mainStep) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), mainPaint);
    }
    for (double i = 0; i < size.height; i += mainStep) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), mainPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
