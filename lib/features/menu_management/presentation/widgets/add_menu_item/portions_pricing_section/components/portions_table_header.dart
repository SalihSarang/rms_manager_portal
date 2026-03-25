import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [PortionsTableHeader] provides the stylized column labels for the portions table.
/// It ensures visual consistency between the header and the [PortionTableRow] data.
class PortionsTableHeader extends StatelessWidget {
  const PortionsTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NeutralColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Portion Name',
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
              style: TextStyle(
                color: TextColors.secondary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
