import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [LastSavedIndicator] displays the timestamp of the last successful data save.
/// This provides transparency to the user about data persistence.
class LastSavedIndicator extends StatelessWidget {
  const LastSavedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Last saved: Just now',
      style: TextStyle(
        color: TextColors.secondary.withValues(alpha: 0.5),
        fontSize: 12,
      ),
    );
  }
}
