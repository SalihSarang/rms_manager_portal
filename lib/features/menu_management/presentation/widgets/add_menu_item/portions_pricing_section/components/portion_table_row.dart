import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

/// [PortionTableRow] visualizes a single portion size entry.
/// It displays the name, cost, and quantity metrics in a tabular format.
class PortionTableRow extends StatelessWidget {
  /// The portion data object to render.
  final PortionAndPrice portion;

  /// Callback to remove this specific portion from the list.
  final VoidCallback onRemove;

  const PortionTableRow({
    super.key,
    required this.portion,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              portion.name,
              style: const TextStyle(
                color: TextColors.secondary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(
              portion.price.toStringAsFixed(2),
              style: const TextStyle(
                color: TextColors.secondary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Text(
              '${portion.count ?? ''} ${portion.unit ?? ''}'.trim(),
              style: const TextStyle(
                color: TextColors.secondary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 60,
            child: IconButton(
              onPressed: onRemove,
              icon: const Icon(
                Icons.delete_outline,
                size: 20,
                color: TextColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
