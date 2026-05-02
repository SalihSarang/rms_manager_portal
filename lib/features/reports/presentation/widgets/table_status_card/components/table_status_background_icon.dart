import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class TableStatusBackgroundIcon extends StatelessWidget {
  final bool showAsAvailable;

  const TableStatusBackgroundIcon({super.key, required this.showAsAvailable});

  @override
  Widget build(BuildContext context) {
    if (!showAsAvailable) return const SizedBox.shrink();

    return const Center(
      child: Opacity(
        opacity: 0.07,
        child: Icon(Icons.restaurant, size: 48, color: TextColors.primary),
      ),
    );
  }
}
