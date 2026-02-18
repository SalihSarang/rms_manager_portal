import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:manager_portal/features/staff/presentation/widgets/staff_listing_table/components/action_button.dart';
import 'package:manager_portal/features/staff/presentation/utils/staff_utils.dart';

class StaffTableRow extends DataRow2 {
  final StaffModel staff;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  StaffTableRow({required this.staff, this.onEdit, this.onDelete})
    : super(
        cells: [
          // Name
          DataCell(
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: NeutralColors.card,
                  radius: 16,
                  backgroundImage: NetworkImage(staff.avatar),
                  child: Text(
                    StaffUtils.getInitials(staff.name),
                    style: const TextStyle(
                      color: TextColors.inverse,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
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
            Row(
              children: [
                ActionButton(icon: Icons.edit_outlined, onTap: onEdit ?? () {}),
                const SizedBox(width: 8),
                ActionButton(
                  icon: Icons.delete_outline,
                  onTap: onDelete ?? () {},
                ),
              ],
            ),
          ),
        ],
      );
}
