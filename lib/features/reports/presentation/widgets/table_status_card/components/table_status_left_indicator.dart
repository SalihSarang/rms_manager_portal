import 'package:flutter/material.dart';

class TableStatusLeftIndicator extends StatelessWidget {
  final Color statusColor;

  const TableStatusLeftIndicator({super.key, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 12,
      bottom: 12,
      child: Container(
        width: 4,
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(2),
          ),
          boxShadow: [
            BoxShadow(
              color: statusColor.withValues(alpha: 0.5),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
