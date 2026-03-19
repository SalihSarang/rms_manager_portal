import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class LibraryCardDragHandle extends StatelessWidget {
  final bool isHovered;
  final Color accentColor;

  const LibraryCardDragHandle({
    super.key,
    required this.isHovered,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isHovered ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 180),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.drag_indicator_rounded,
            color: isHovered ? accentColor : NeutralColors.icon,
            size: 18,
          ),
          const SizedBox(height: 2),
          Text(
            'drag',
            style: TextStyle(
              fontSize: 9,
              color: isHovered
                  ? accentColor.withValues(alpha: 0.8)
                  : NeutralColors.icon,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
