import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// A sidebar component that displays a library of draggable table templates.
class TablesLibrary extends StatelessWidget {
  /// Creates a [TablesLibrary].
  const TablesLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: const Color(0xFF1E1E2D),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'HALL',
            style: TextStyle(
              color: TextColors.secondary,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A3C),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: NeutralColors.border.withAlpha(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Main Hall', style: TextStyle(color: TextColors.primary)),
                Icon(Icons.keyboard_arrow_down, color: TextColors.secondary, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Library',
            style: TextStyle(
              color: TextColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _buildSection('RECTANGULAR'),
                _buildLibraryItem(
                  '6 Seats',
                  '6 Seats',
                  TableShape.rectangle,
                  6,
                ),
                const SizedBox(height: 20),
                _buildSection('ROUND'),
                _buildLibraryItem(
                  '2 Seats',
                  '2 Seats',
                  TableShape.circle,
                  2,
                ),
                const SizedBox(height: 12),
                _buildLibraryItem(
                  '4 Seats',
                  '4 Seats',
                  TableShape.circle,
                  4,
                ),
                const SizedBox(height: 20),
                _buildSection('BOOTHS'),
                _buildLibraryItem(
                  'Corner Booth',
                  '5-6 Seats',
                  TableShape.square, // Approximate for now
                  6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: TextColors.secondary,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildLibraryItem(String title, String subtitle, TableShape shape, int capacity) {
    return Draggable<TableModel>(
      data: TableModel(
        id: -1, // Temporary ID for new tables
        name: 'New Table',
        capacity: capacity,
        status: TableStatus.available,
        shape: shape,
        currentGuests: 0,
        hallId: 'Main Hall',
        posX: 0,
        posY: 0,
      ),
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A3C).withAlpha(200),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF3B71FE)),
          ),
          child: Row(
            children: [
              _buildShapePreview(shape),
              const SizedBox(width: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: TextColors.primary)),
                  Text(subtitle, style: const TextStyle(color: TextColors.secondary, fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3C),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: NeutralColors.border.withAlpha(15)),
        ),
        child: Row(
          children: [
            _buildShapePreview(shape),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: TextColors.primary, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: TextColors.secondary, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShapePreview(TableShape shape) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: NeutralColors.border.withAlpha(25)),
      ),
      child: Center(
        child: Icon(
          shape == TableShape.circle
              ? Icons.circle_outlined
              : shape == TableShape.rectangle
                  ? Icons.rectangle_outlined
                  : Icons.square_outlined,
          color: TextColors.secondary,
          size: 20,
        ),
      ),
    );
  }
}
