import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// Displays help links or support information at the bottom of the login screen.
class LoginFooter extends StatelessWidget {
  /// Callback triggered when the help text is tapped.
  final VoidCallback onHelpTap;

  /// Creates a [LoginFooter] with the given [onHelpTap] callback.
  const LoginFooter({super.key, required this.onHelpTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onHelpTap,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.help_outline, size: 14, color: TextColors.secondary),
              SizedBox(width: 4),
              Text(
                'Need Help?',
                style: TextStyle(color: TextColors.secondary, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
