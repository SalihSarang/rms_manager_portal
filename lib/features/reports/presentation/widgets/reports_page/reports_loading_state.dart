import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';

class ReportsLoadingState extends StatelessWidget {
  const ReportsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: StatusColors.preparing),
    );
  }
}
