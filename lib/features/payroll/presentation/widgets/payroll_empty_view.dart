import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PayrollEmptyView extends StatelessWidget {
  final String message;

  const PayrollEmptyView({
    super.key,
    this.message = 'No staff match the selected filters.',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: const TextStyle(color: TextColors.secondary)),
    );
  }
}
