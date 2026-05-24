import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [AddOnsTableHeader] provides the column labels for the add-ons and pricing table.
/// It aligns with the fields displayed in [AddOnTableRow].
class AddOnsTableHeader extends StatelessWidget {
  const AddOnsTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NeutralColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Add-ons Name',
              style: TextStyle(
                color: TextColors.secondary.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(
              'Price (\$)',
              style: TextStyle(
                color: TextColors.secondary.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Text(
              'Count',
              style: TextStyle(
                color: TextColors.secondary.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const SizedBox(
            width: 60,
            child: Text(
              'Actions',
              textAlign: TextAlign.center,
              style: TextStyle(color: TextColors.secondary, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
