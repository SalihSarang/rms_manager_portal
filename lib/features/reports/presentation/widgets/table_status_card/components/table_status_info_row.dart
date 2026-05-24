import 'package:flutter/material.dart';
import 'info_tile.dart';

class TableStatusInfoRow extends StatelessWidget {
  final int totalGuests;
  final String? duration;
  final bool hasActiveOrder;
  final Color statusColor;

  const TableStatusInfoRow({
    super.key,
    required this.totalGuests,
    this.duration,
    required this.hasActiveOrder,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InfoTile(
            label: 'PARTY SIZE',
            value: '$totalGuests Guests',
            icon: Icons.people_outline,
          ),
        ),
        Expanded(
          child: InfoTile(
            label: 'DURATION',
            value: duration ?? '--',
            icon: Icons.access_time,
            iconColor: hasActiveOrder ? statusColor : null,
          ),
        ),
      ],
    );
  }
}
