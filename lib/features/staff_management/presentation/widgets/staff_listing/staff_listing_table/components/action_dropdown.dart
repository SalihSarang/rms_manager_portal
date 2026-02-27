import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/staff_management/presentation/pages/staff_details_screen.dart';

class ActionDropdown extends StatelessWidget {
  final StaffModel staff;
  final VoidCallback? onEdit;
  final VoidCallback? onToggleStatus;
  final VoidCallback? onDelete;

  const ActionDropdown({
    super.key,
    required this.staff,
    this.onEdit,
    this.onToggleStatus,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: NeutralColors.icon, size: 20),
      color: NeutralColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      offset: const Offset(0, 40),
      onSelected: (value) {
        if (value == 'viewDetails') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StaffDetailsScreen(staffId: staff.id),
            ),
          );
        } else if (value == 'edit') {
          onEdit?.call();
        } else if (value == 'toggleStatus') {
          onToggleStatus?.call();
        } else if (value == 'delete') {
          onDelete?.call();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'viewDetails',
          child: Row(
            children: const [
              Icon(
                Icons.visibility_outlined,
                size: 18,
                color: NeutralColors.icon,
              ),
              SizedBox(width: 12),
              Text(
                'View Details',
                style: TextStyle(
                  color: TextColors.inverse,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: const [
              Icon(Icons.edit_outlined, size: 18, color: NeutralColors.icon),
              SizedBox(width: 12),
              Text(
                'Edit',
                style: TextStyle(
                  color: TextColors.inverse,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'toggleStatus',
          child: Row(
            children: [
              Icon(
                staff.isActive ? Icons.block : Icons.lock_open,
                size: 18,
                color: staff.isActive
                    ? SemanticColors.error
                    : SemanticColors.success,
              ),
              const SizedBox(width: 12),
              Text(
                staff.isActive ? 'Block' : 'Unblock',
                style: TextStyle(
                  color: staff.isActive
                      ? SemanticColors.error
                      : SemanticColors.success,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: const [
              Icon(Icons.delete_outline, size: 18, color: SemanticColors.error),
              SizedBox(width: 12),
              Text(
                'Delete',
                style: TextStyle(
                  color: SemanticColors.error,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
