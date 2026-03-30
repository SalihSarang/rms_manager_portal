import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffIdProofPreviewError extends StatelessWidget {
  final String message;

  const StaffIdProofPreviewError({
    super.key,
    this.message = 'Failed to load ID Proof',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: TextColors.secondary)),
        ],
      ),
    );
  }
}
