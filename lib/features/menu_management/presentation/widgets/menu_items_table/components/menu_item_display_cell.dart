import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/item_image_placeholder.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [MenuItemDisplayCell] handles the rendering of the food item's image and name.
/// It uses a network image with a fallback static placeholder.
class MenuItemDisplayCell extends StatelessWidget {
  final String imageUrl;
  final String itemName;

  const MenuItemDisplayCell({
    super.key,
    required this.imageUrl,
    required this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const ItemImagePlaceholder(),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const ItemImagePlaceholder();
                  },
                )
              : const ItemImagePlaceholder(),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            itemName,
            style: const TextStyle(
              color: TextColors.primary,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
