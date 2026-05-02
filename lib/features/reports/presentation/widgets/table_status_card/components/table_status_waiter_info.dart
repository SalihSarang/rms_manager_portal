import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class TableStatusWaiterInfo extends StatelessWidget {
  final String waiterNames;

  const TableStatusWaiterInfo({super.key, required this.waiterNames});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: NeutralColors.surfaceLighter,
          child: const Icon(
            Icons.person,
            size: 16,
            color: TextColors.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ASSIGNED WAITER',
                style: TextStyle(
                  color: TextColors.muted,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                waiterNames,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: TextColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
