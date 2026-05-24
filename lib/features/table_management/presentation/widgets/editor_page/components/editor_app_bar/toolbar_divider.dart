import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class ToolbarDivider extends StatelessWidget {
  const ToolbarDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: NeutralColors.border,
    );
  }
}
