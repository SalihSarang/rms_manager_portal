import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class ReportsErrorState extends StatelessWidget {
  final String message;

  const ReportsErrorState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: const TextStyle(color: TextColors.primary)),
    );
  }
}
