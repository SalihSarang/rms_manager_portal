import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [CancelActionButton] allows the user to navigate back without saving changes.
/// This component is automatically disabled during an active submission.
class CancelActionButton extends StatelessWidget {
  final bool isSubmitting;

  const CancelActionButton({super.key, required this.isSubmitting});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // Disables the button when a save is in progress
      onPressed: isSubmitting ? null : () => Navigator.of(context).pop(),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: NeutralColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        'Cancel',
        style: TextStyle(color: TextColors.primary, fontSize: 13),
      ),
    );
  }
}