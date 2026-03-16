import 'package:flutter/material.dart';
import 'package:manager_portal/features/table_management/presentation/pages/table_detail_screen.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// A widget representing a single restaurant table with a premium design matching the reference image.
///
/// Displays the table name in the center and seat count in a top-right bubble.
/// Responds to taps by navigating to the [TableDetailScreen].
class TableWidget extends StatelessWidget {
  /// The [TableModel] data for this table.
  final TableModel table;

  /// Whether this widget is being used as a drag feedback.
  final bool isFeedback;

  /// Creates a [TableWidget].
  const TableWidget({super.key, required this.table, this.isFeedback = false});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (table.status) {
      case TableStatus.available:
        statusColor = SemanticColors.success;
        break;
      case TableStatus.occupied:
        statusColor = SemanticColors.error;
        break;
      case TableStatus.partiallyOccupied:
        statusColor = Colors.orange;
        break;
      case TableStatus.disabled:
        statusColor = Colors.grey;
        break;
    }

    final double width = _getWidth(table.shape);
    final double height = _getHeight(table.shape);

    return GestureDetector(
      onTap: isFeedback
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableDetailScreen(table: table),
                ),
              );
            },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Table Body
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2D).withValues(alpha: isFeedback ? 0.6 : 0.95),
              shape: table.shape == TableShape.circle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: table.shape == TableShape.circle ? null : BorderRadius.circular(12),
              border: Border.all(
                color: isFeedback ? Colors.blue : statusColor.withValues(alpha: 0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isFeedback ? Colors.blue : statusColor).withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                table.name,
                style: const TextStyle(
                  color: TextColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // Seat Count Bubble (Top Right)
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isFeedback ? Colors.blue : const Color(0xFF2A2A3C),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                '${table.capacity}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getWidth(TableShape shape) {
    switch (shape) {
      case TableShape.square:
        return 90;
      case TableShape.rectangle:
        return 140;
      case TableShape.circle:
        return 100;
    }
  }

  double _getHeight(TableShape shape) {
    switch (shape) {
      case TableShape.square:
        return 90;
      case TableShape.rectangle:
        return 90;
      case TableShape.circle:
        return 100;
    }
  }
}
