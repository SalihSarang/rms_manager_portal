import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class TableWidget extends StatelessWidget {
  final TableModel table;
  final bool isFeedback;

  const TableWidget({super.key, required this.table, this.isFeedback = false});

  @override
  Widget build(BuildContext context) {
    Color tableColor;
    switch (table.status) {
      case TableStatus.available:
        tableColor = SemanticColors.success;
        break;
      case TableStatus.occupied:
        tableColor = SemanticColors.error;
        break;
      case TableStatus.partiallyOccupied:
        tableColor = Colors.orange;
        break;
      case TableStatus.disabled:
        tableColor = Colors.grey;
        break;
    }

    return Container(
      width: _getWidth(table.shape),
      height: _getHeight(table.shape),
      decoration: BoxDecoration(
        color: tableColor.withValues(alpha: isFeedback ? 0.6 : 1.0),
        shape: table.shape == TableShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        borderRadius: table.shape == TableShape.circle
            ? null
            : BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              table.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              '${table.capacity}',
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ],
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
