import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_item_action_buttons.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_item_display_cell.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_item_status_badge.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [MenuItemsTableRow] defines a single row in the food items table.
/// It acts as a structural layout that maps food properties to specialized cell widgets.
class MenuItemsTableRow extends DataRow2 {
  /// The food item entity to represent.
  final FoodModel item;

  /// Callback to trigger the edit dialog for this item.
  final VoidCallback? onEdit;
  final VoidCallback? onToggleStatus;

  /// The rank or index of the item (1-indexed based on current pagination).
  final int index;

  MenuItemsTableRow({
    required this.item,
    required this.index,
    this.onEdit,
    this.onToggleStatus,
    super.onTap,
  }) : super(
         cells: [
           // --- Column: S.No ---
           DataCell(
             Text(
               '$index',
               style: const TextStyle(
                 color: TextColors.secondary,
                 fontWeight: FontWeight.w500,
               ),
             ),
           ),

           // --- Column: Item (Image + Name) ---
           DataCell(
             MenuItemDisplayCell(imageUrl: item.imageUrl, itemName: item.name),
           ),

           // --- Column: Description ---
           DataCell(
             Text(
               item.description,
               style: const TextStyle(
                 color: TextColors.secondary,
                 fontSize: 12,
               ),
               overflow: TextOverflow.ellipsis,
               maxLines: 2,
             ),
           ),

           // --- Column: Price (Formatted) ---
           DataCell(
             Text(
               item.portions.isNotEmpty
                   ? '\$ ${item.portions.first.price.toStringAsFixed(2)}'
                   : '—',
               style: const TextStyle(
                 color: TextColors.inverse,
                 fontWeight: FontWeight.w500,
               ),
             ),
           ),

           // --- Column: Status (Availability Badge) ---
           DataCell(MenuItemStatusBadge(isAvailable: item.isAvailable)),

           // --- Column: Actions (Edit/Toggle) ---
           DataCell(
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
               decoration: BoxDecoration(
                 color: item.isAvailable
                     ? SemanticColors.success.withAlpha(25)
                     : SemanticColors.error.withAlpha(25),
                 borderRadius: BorderRadius.circular(4),
               ),
               child: Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Container(
                     width: 6,
                     height: 6,
                     decoration: BoxDecoration(
                       color: item.isAvailable
                           ? SemanticColors.success
                           : SemanticColors.error,
                       shape: BoxShape.circle,
                     ),
                   ),
                   const SizedBox(width: 6),
                   Text(
                     item.isAvailable ? 'AVAILABLE' : 'SOLD OUT',
                     style: TextStyle(
                       color: item.isAvailable
                           ? SemanticColors.success
                           : SemanticColors.error,
                       fontSize: 11,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ],
               ),
             ),
           ),
           // Actions
           DataCell(
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 _ActionIconButton(
                   icon: Icons.edit_outlined,
                   onTap: onEdit,
                   tooltip: 'Edit',
                 ),
                 const SizedBox(width: 4),
                 _ActionIconButton(
                   icon: item.isAvailable
                       ? Icons.block
                       : Icons.check_circle_outline,
                   color: item.isAvailable
                       ? SemanticColors.error
                       : SemanticColors.success,
                   onTap: onToggleStatus,
                   tooltip: item.isAvailable
                       ? 'Mark Sold Out'
                       : 'Mark Available',
                 ),
               ],
             ),
           ),
         ],
       );
}

class _ItemPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: NeutralColors.border),
      ),
      child: const Icon(
        Icons.image_outlined,
        size: 16,
        color: TextColors.secondary,
      ),
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String tooltip;
  final Color? color;

  const _ActionIconButton({
    required this.icon,
    required this.tooltip,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 18, color: color ?? TextColors.secondary),
        ),
      ),
    );
  }
}
