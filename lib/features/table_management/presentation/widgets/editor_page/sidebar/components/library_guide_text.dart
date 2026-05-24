import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

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
              color: TableColors.rectangular.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: TableColors.rectangular.withValues(alpha: 0.25),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.drag_indicator_rounded,
                    size: 11, color: TableColors.rectangular),
                SizedBox(width: 4),
                Text(
                  'Drag to canvas',
                  style: TextStyle(
                    fontSize: 10,
                    color: TableColors.rectangular,
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
