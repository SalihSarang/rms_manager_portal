import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class TableManagementLoadingView extends StatelessWidget {
  const TableManagementLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: PrimaryColors.defaultColor),
    );
  }
}
