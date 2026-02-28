import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/staff_utils.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_table/components/action_dropdown.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class StaffTableRow extends DataRow2 {
  final StaffModel staff;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleStatus;
  final VoidCallback? onTap;
  final int index;

  StaffTableRow({
    required this.staff,
    required this.index,
    this.onEdit,
    this.onDelete,
    this.onToggleStatus,
    this.onTap,
  }) : super(
         onTap: onTap,
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
           // Name
           DataCell(
             Row(
               children: [
                 CircleAvatar(
                   backgroundColor: NeutralColors.card,
                   radius: 16,
                   backgroundImage: staff.avatar.isNotEmpty
                       ? NetworkImage(staff.avatar)
                       : null,
                   child: staff.avatar.isEmpty
                       ? Text(
                           StaffUtils.getInitials(staff.name),
                           style: const TextStyle(
                             color: TextColors.inverse,
                             fontSize: 11,
                             fontWeight: FontWeight.bold,
                           ),
                         )
                       : null,
                 ),
                 const SizedBox(width: 10),
                 Flexible(
                   child: Text(
                     staff.name,
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
           // Role
           DataCell(
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
               decoration: BoxDecoration(
                 color: NeutralColors.surface,
                 borderRadius: BorderRadius.circular(10),
                 border: Border.all(color: NeutralColors.border),
               ),
               child: Text(
                 staff.role.name.toUpperCase(),
                 style: const TextStyle(
                   color: PrimaryColors.defaultColor,
                   fontSize: 11,
                   fontWeight: FontWeight.w500,
                 ),
               ),
             ),
           ),
           // Email
           DataCell(
             Text(
               staff.email,
               style: const TextStyle(color: TextColors.secondary),
             ),
           ),
           // Status
           DataCell(
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
               decoration: BoxDecoration(
                 color: staff.isActive
                     ? SemanticColors.success.withValues(alpha: 0.1)
                     : SemanticColors.error.withValues(alpha: 0.1),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Text(
                 staff.isActive ? 'Active' : 'Blocked',
                 style: TextStyle(
                   color: staff.isActive
                       ? SemanticColors.success
                       : SemanticColors.error,
                   fontSize: 11,
                   fontWeight: FontWeight.w500,
                 ),
               ),
             ),
           ),
           // Last Active
           DataCell(
             Row(
               children: [
                 const Icon(
                   Icons.access_time,
                   size: 14,
                   color: TextColors.secondary,
                 ),
                 const SizedBox(width: 6),
                 Text(
                   StaffUtils.formatDate(staff.lastActive),
                   style: const TextStyle(color: TextColors.secondary),
                 ),
               ],
             ),
           ),
           // Actions
           DataCell(
             ActionDropdown(
               staff: staff,
               onEdit: onEdit,
               onToggleStatus: onToggleStatus,
               onDelete: onDelete,
             ),
           ),
         ],
       );
}
