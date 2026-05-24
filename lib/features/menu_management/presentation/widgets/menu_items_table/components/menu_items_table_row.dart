import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_item_action_buttons.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_item_display_cell.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_items_table/components/menu_item_status_badge.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [MenuItemsTableRow] defines a single row in the food items table.
/// It acts as a structural layout that maps food properties to specialized cell widgets.
class MenuItemsTableRow extends DataRow2 {
  /// The food item entity to represent.
  final FoodModel item;

  /// Callback to trigger the edit dialog for this item.
  final VoidCallback? onEdit;

  /// Callback to toggle availability status via the parent BLoC.
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
                 color: TextColors.primary,
                 fontWeight: FontWeight.w500,
               ),
             ),
           ),

           // --- Column: Status (Availability Badge) ---
           DataCell(MenuItemStatusBadge(isAvailable: item.isAvailable)),

           // --- Column: Actions (Edit/Toggle) ---
           DataCell(
             MenuItemActionButtons(
               isAvailable: item.isAvailable,
               onEdit: onEdit,
               onToggleStatus: onToggleStatus,
             ),
           ),
         ],
       );
}
