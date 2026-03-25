import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/item_shimmer_placeholder.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [MenuItemDisplayCell] handles the rendering of the food item's image and name.
/// It uses a network image with a shimmer loading state and a fallback placeholder.
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
        if (imageUrl.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const ItemShimmerPlaceholder();
              },
              errorBuilder: (context, error, stack) =>
                  const ItemShimmerPlaceholder(),
            ),
          )
        else
          const ItemShimmerPlaceholder(),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            itemName,
            style: const TextStyle(
              color: TextColors.inverse,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
