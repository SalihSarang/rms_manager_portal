import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class LibraryCardInfo extends StatelessWidget {
  final TableModel template;
  final int seats;
  final Color accentColor;

  const LibraryCardInfo({
    super.key,
    required this.template,
    required this.seats,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            template.shape == TableShape.circle
                ? 'Round Table'
                : 'Rectangle Table',
            style: TextStyle(
              color: TextColors.primary.withValues(alpha: 0.5),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            template.name,
            style: const TextStyle(
              color: TextColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.chair_rounded,
                size: 11,
                color: accentColor,
              ),
              const SizedBox(width: 4),
              Text(
                '$seats seats',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
