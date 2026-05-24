import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffDetailsGlassDivider extends StatelessWidget {
  const StaffDetailsGlassDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: TextColors.primary.withValues(alpha: 0.08), height: 24);
  }
}