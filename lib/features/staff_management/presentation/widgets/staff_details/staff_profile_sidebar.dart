import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/staff_utils.dart';
import 'components/image_lightbox.dart';

/// Left sidebar showing the staff member's avatar, personal details, and shift status.
class StaffProfileSidebar extends StatelessWidget {
  final StaffModel staff;

  const StaffProfileSidebar({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAvatar(context),
            const SizedBox(height: 16),
            _buildNameAndRole(),
            const SizedBox(height: 20),
            const Divider(color: NeutralColors.border),
            const SizedBox(height: 16),
            _buildSectionLabel('PERSONAL DETAILS'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.email_outlined, 'Email Address', staff.email),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.phone_outlined, 'Phone Number', staff.phoneNumber),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.badge_outlined,
              'Designation',
              '${staff.role.name[0].toUpperCase()}${staff.role.name.substring(1)}',
            ),
            const SizedBox(height: 20),
            const Divider(color: NeutralColors.border),
            const SizedBox(height: 16),
            _buildSectionLabel('SHIFT STATUS'),
            const SizedBox(height: 12),
            _buildShiftStatusBadge(),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.access_time_outlined,
              'Last Active',
              StaffUtils.formatDate(staff.lastActive),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final Widget avatar = staff.avatar.isNotEmpty
        ? CircleAvatar(
            radius: 44,
            backgroundImage: NetworkImage(staff.avatar),
            backgroundColor: NeutralColors.card,
          )
        : CircleAvatar(
            radius: 44,
            backgroundColor: StatusColors.preparingBg,
            child: Text(
              StaffUtils.getInitials(staff.name),
              style: const TextStyle(
                color: StatusColors.preparingText,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          );

    if (staff.avatar.isEmpty) return avatar;

    return GestureDetector(
      onTap: () => showStaffImageLightbox(context, staff.avatar, 'Profile Photo'),
      child: avatar,
    );
  }

  Widget _buildNameAndRole() {
    return Column(
      children: [
        Text(
          staff.name,
          style: const TextStyle(
            color: TextColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: [
            _buildPill(
              '${staff.role.name[0].toUpperCase()}${staff.role.name.substring(1)}',
              PrimaryColors.defaultColor,
            ),
            _buildPill(
              staff.isActive ? 'Active' : 'Inactive',
              staff.isActive ? SemanticColors.success : SemanticColors.error,
              dotted: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPill(String label, Color color, {bool dotted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotted) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
          ],
          Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: TextColors.secondary,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: TextColors.secondary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: TextColors.secondary, fontSize: 11)),
              const SizedBox(height: 2),
              Text(
                value.isEmpty ? '—' : value,
                style: TextStyle(
                  color: value.isEmpty ? TextColors.muted : TextColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShiftStatusBadge() {
    final (String label, Color color, IconData icon) = switch (staff.shiftStatus) {
      ShiftStatus.active => ('On Shift', SemanticColors.success, Icons.play_circle_outline),
      ShiftStatus.paused => ('Paused', StatusColors.pending, Icons.pause_circle_outline),
      ShiftStatus.ended => ('Shift Ended', StatusColors.paid, Icons.check_circle_outline),
      ShiftStatus.missed => ('Missed', SemanticColors.error, Icons.cancel_outlined),
      ShiftStatus.notStarted => ('Not Started', TextColors.secondary, Icons.radio_button_unchecked),
    };

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
