import 'package:flutter/material.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../library_card.dart';

class TableLibrary extends StatelessWidget {
  const TableLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SectionLabel(
              label: 'Rectangular',
              icon: Icons.crop_square_rounded,
              color: Color(0xFF7C5CFC),
            ),
            const SizedBox(height: 8),
            const LibraryCard(
              name: '2 Seats',
              shape: TableShape.rectangle,
              seats: 2,
              accentColor: Color(0xFF7C5CFC),
            ),
            const LibraryCard(
              name: '4 Seats',
              shape: TableShape.rectangle,
              seats: 4,
              accentColor: Color(0xFF7C5CFC),
            ),
            const LibraryCard(
              name: '6 Seats',
              shape: TableShape.rectangle,
              seats: 6,
              accentColor: Color(0xFF7C5CFC),
            ),
            const LibraryCard(
              name: '8 Seats',
              shape: TableShape.rectangle,
              seats: 8,
              accentColor: Color(0xFF7C5CFC),
            ),
            const SizedBox(height: 20),
            const _SectionLabel(
              label: 'Round',
              icon: Icons.radio_button_checked_rounded,
              color: Color(0xFF5CE0E6),
            ),
            const SizedBox(height: 8),
            const LibraryCard(
              name: '2 Seats',
              shape: TableShape.circle,
              seats: 2,
              accentColor: Color(0xFF5CE0E6),
            ),
            const LibraryCard(
              name: '4 Seats',
              shape: TableShape.circle,
              seats: 4,
              accentColor: Color(0xFF5CE0E6),
            ),
            const LibraryCard(
              name: '6 Seats',
              shape: TableShape.circle,
              seats: 6,
              accentColor: Color(0xFF5CE0E6),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _SectionLabel({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 4),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 13, color: color.withValues(alpha: 0.8)),
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
