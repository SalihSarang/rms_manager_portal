import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';

/// [AddOnTableRow] displays the name, price, and quantity details for a single add-on.
/// It includes a delete action to remove the entry from the list.
class AddOnTableRow extends StatelessWidget {
  /// The add-on data to be displayed in the row.
  final AddOnsModel addOn;

  /// Callback to remove this add-on from the collection.
  final VoidCallback onRemove;

  const AddOnTableRow({super.key, required this.addOn, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              addOn.name,
              style: const TextStyle(color: TextColors.secondary, fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(
              addOn.price.toStringAsFixed(2),
              style: const TextStyle(color: TextColors.secondary, fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Text(
              '${addOn.count ?? ''} ${addOn.unit ?? ''}'.trim(),
              style: const TextStyle(color: TextColors.secondary, fontSize: 14),
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
