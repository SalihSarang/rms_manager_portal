import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class OverviewHeader extends StatelessWidget {
  const OverviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Executive Overview',
          style: TextStyle(
            color: TextColors.primary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
