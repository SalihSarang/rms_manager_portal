import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class MenuItemsTableRow extends DataRow2 {
  final FoodModel item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleStatus;
  final int index;

  MenuItemsTableRow({
    required this.item,
    required this.index,
    this.onEdit,
    this.onDelete,
    this.onToggleStatus,
    super.onTap,
  }) : super(
         cells: [
           // S.No
           DataCell(
             Text(
               '$index',
               style: const TextStyle(
                 color: TextColors.secondary,
                 fontWeight: FontWeight.w500,
               ),
             ),
           ),
           // Item
           DataCell(
             Row(
               children: [
                 if (item.imageUrl.isNotEmpty)
                   ClipRRect(
                     borderRadius: BorderRadius.circular(6),
                     child: Image.network(
                       item.imageUrl,
                       width: 32,
                       height: 32,
                       fit: BoxFit.cover,
                       errorBuilder: (context, error, stack) =>
                           _ItemPlaceholder(),
                     ),
                   )
                 else
                   _ItemPlaceholder(),
                 const SizedBox(width: 12),
                 Flexible(
                   child: Text(
                     item.name,
                     style: const TextStyle(
                       color: TextColors.inverse,
                       fontWeight: FontWeight.w500,
                     ),
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
               ],
             ),
           ),
           // Description
           // Description
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
           // Price
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
           // Status
           DataCell(
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
               decoration: BoxDecoration(
                 color: item.isAvailable
                     ? SemanticColors.success.withAlpha(25)
                     : SemanticColors.warning.withAlpha(25),
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
                           : SemanticColors.warning,
                       shape: BoxShape.circle,
                     ),
                   ),
                   const SizedBox(width: 6),
                   Text(
                     item.isAvailable ? 'AVAILABLE' : 'SOLD OUT',
                     style: TextStyle(
                       color: item.isAvailable
                           ? SemanticColors.success
                           : SemanticColors.warning,
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
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 _ActionIconButton(
                   icon: Icons.edit_outlined,
                   onTap: onEdit,
                   tooltip: 'Edit',
                 ),
                 const SizedBox(width: 4),
                 _ActionIconButton(
                   icon: Icons.block,
                   onTap: onToggleStatus,
                   tooltip: item.isAvailable
                       ? 'Mark Sold Out'
                       : 'Mark Available',
                 ),
                 const SizedBox(width: 4),
                 _ActionIconButton(
                   icon: Icons.delete_outline,
                   onTap: onDelete,
                   tooltip: 'Delete',
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

  const _ActionIconButton({
    required this.icon,
    required this.tooltip,
    this.onTap,
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
          child: Icon(icon, size: 18, color: TextColors.secondary),
        ),
      ),
    );
  }
}
