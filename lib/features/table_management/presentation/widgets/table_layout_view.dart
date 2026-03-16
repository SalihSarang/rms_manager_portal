import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_management_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/widgets/table_widget.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

/// A zoomable and scrollable view for arranging restaurant tables on a grid.
///
/// Refined to match the reference image with dashed boundaries and entrance labels.
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
          id: DateTime.now().millisecondsSinceEpoch % 10000,
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
                clipBehavior: Clip.none,
                children: [
                  // Background hall with grid and boundary
                  Container(
                    width: 3000,
                    height: 3000,
                    color: const Color(0xFF161621),
                    child: CustomPaint(
                      painter: HallPainter(),
                    ),
                  ),

                  // Origin Label (0,0)
                  _buildSmallLabel('0,0', const Offset(10, 10)),

                  // Entrance Label at the bottom center of a reasonable hall area (e.g., at 1000px depth)
                  Positioned(
                    left: 450, // Roughly center of a 1000px wide area
                    top: 1500, // Bottom of the initial visible hall
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A3C),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.blue.withAlpha(100)),
                      ),
                      child: const Text(
                        'ENTRANCE',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
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
                                final RenderBox renderBox = context.findRenderObject() as RenderBox;
                                final localOffset = renderBox.globalToLocal(details.offset);
                                
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
      },
    );
  }

  Widget _buildSmallLabel(String text, Offset position) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white24, fontSize: 10),
      ),
    );
  }
}

/// A custom painter that renders the hall grid and the dashed boundary.
class HallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final subPaint = Paint()
      ..color = NeutralColors.border.withAlpha(10)
      ..strokeWidth = 0.5;

    final mainPaint = Paint()
      ..color = NeutralColors.border.withAlpha(25)
      ..strokeWidth = 1.0;

    final dashPaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const double subStep = 40.0;
    const double mainStep = 200.0;

    // 1. Draw grid
    for (double i = 0; i < size.width; i += subStep) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), subPaint);
    }
    for (double i = 0; i < size.height; i += subStep) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), subPaint);
    }

    for (double i = 0; i < size.width; i += mainStep) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), mainPaint);
    }
    for (double i = 0; i < size.height; i += mainStep) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), mainPaint);
    }

    // 2. Draw dashed boundary (e.g., a 1000x1500 area)
    final Rect boundary = const Rect.fromLTWH(50, 50, 900, 1450);
    _drawDashedRect(canvas, boundary, dashPaint);
  }

  void _drawDashedRect(Canvas canvas, Rect rect, Paint paint) {
    const double dashWidth = 10.0;
    const double dashSpace = 5.0;

    // Top
    _drawDashedLine(canvas, Offset(rect.left, rect.top), Offset(rect.right, rect.top), paint, dashWidth, dashSpace);
    // Right
    _drawDashedLine(canvas, Offset(rect.right, rect.top), Offset(rect.right, rect.bottom), paint, dashWidth, dashSpace);
    // Bottom
    _drawDashedLine(canvas, Offset(rect.right, rect.bottom), Offset(rect.left, rect.bottom), paint, dashWidth, dashSpace);
    // Left
    _drawDashedLine(canvas, Offset(rect.left, rect.bottom), Offset(rect.left, rect.top), paint, dashWidth, dashSpace);
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint, double dashWidth, double dashSpace) {
    final double distance = (p2 - p1).distance;
    final int dashCount = (distance / (dashWidth + dashSpace)).floor();
    final Offset direction = (p2 - p1) / distance;

    for (int i = 0; i < dashCount; i++) {
      final Offset start = p1 + direction * i.toDouble() * (dashWidth + dashSpace);
      canvas.drawLine(start, start + direction * dashWidth, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
