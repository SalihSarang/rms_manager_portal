import 'package:flutter/material.dart';

class LibraryGuideText extends StatelessWidget {
  const LibraryGuideText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF7C5CFC).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF7C5CFC).withValues(alpha: 0.25),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.drag_indicator_rounded, size: 11, color: Color(0xFF7C5CFC)),
                SizedBox(width: 4),
                Text(
                  'Drag to canvas',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7C5CFC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
