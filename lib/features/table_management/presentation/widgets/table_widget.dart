import 'package:flutter/material.dart';
import 'package:manager_portal/features/table_management/presentation/pages/table_detail_screen.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// A widget representing a single restaurant table with a premium design.
///
/// Displays the table name, capacity, and current status.
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
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3C).withValues(alpha: isFeedback ? 0.6 : 0.9),
          shape: table.shape == TableShape.circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: table.shape == TableShape.circle ? null : BorderRadius.circular(12),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: statusColor.withValues(alpha: 0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: table.shape == TableShape.circle ? BorderRadius.circular(width / 2) : BorderRadius.circular(12),
          child: Stack(
            children: [
              // Subtle background gradient based on status
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        statusColor.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      table.name,
                      style: const TextStyle(
                        color: TextColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${table.capacity}',
                        style: const TextStyle(color: TextColors.secondary, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              // Status dot
              Positioned(
                top: 8,
                right: table.shape == TableShape.circle ? 15 : 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getWidth(TableShape shape) {
    switch (shape) {
      case TableShape.square:
        return 80;
      case TableShape.rectangle:
        return 120;
      case TableShape.circle:
        return 90;
    }
  }

  double _getHeight(TableShape shape) {
    switch (shape) {
      case TableShape.square:
        return 80;
      case TableShape.rectangle:
        return 80;
      case TableShape.circle:
        return 90;
    }
  }
}
