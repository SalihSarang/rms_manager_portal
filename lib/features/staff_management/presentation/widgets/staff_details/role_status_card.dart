import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'components/glass_card.dart';
import 'components/glass_divider.dart';
import 'components/card_header.dart';
import 'components/verify_row.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/staff_utils.dart';

class StaffDetailsRoleStatusCard extends StatelessWidget {
  final StaffModel staff;

  const StaffDetailsRoleStatusCard({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return StaffDetailsGlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StaffDetailsCardHeader(
            icon: Icons.manage_accounts_outlined,
            title: 'Role & Access',
          ),
          const StaffDetailsGlassDivider(),
          StaffDetailsVerifyRow(
            icon: Icons.badge_outlined,
            label: 'Assigned Role',
            value:
                '${staff.role.name[0].toUpperCase()}${staff.role.name.substring(1)}',
            isEmpty: false,
          ),
          StaffDetailsVerifyRow(
            icon: staff.isActive
                ? Icons.lock_open_outlined
                : Icons.block_outlined,
            label: 'Account Access',
            value: staff.isActive ? 'Enabled' : 'Disabled',
            isEmpty: false,
            valueColor: staff.isActive
                ? SemanticColors.success
                : SemanticColors.error,
          ),
          StaffDetailsVerifyRow(
            icon: Icons.access_time_outlined,
            label: 'Last Active',
            value: staff.lastActive != null
                ? StaffUtils.formatDateTime12Hour(staff.lastActive!)
                : 'Never',
            isEmpty: false,
          ),
        ],
      ),
    );
  }
}
