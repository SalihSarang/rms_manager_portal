import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'components/glass_card.dart';
import 'components/glass_badge.dart';
import 'components/image_lightbox.dart';

class StaffDetailsIdentityCard extends StatelessWidget {
  final StaffModel staff;

  const StaffDetailsIdentityCard({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return StaffDetailsGlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      child: Row(
        children: [
          // Tappable avatar
          GestureDetector(
            onTap: staff.avatar.isNotEmpty
                ? () => showStaffImageLightbox(
                    context,
                    staff.avatar,
                    'Profile Photo',
                  )
                : null,
            child: staff.avatar.isNotEmpty
                ? CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(staff.avatar),
                    backgroundColor: NeutralColors.card,
                  )
                : CircleAvatar(
                    radius: 36,
                    backgroundColor: NeutralColors.card,
                    child: Text(
                      staff.name.isNotEmpty ? staff.name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        color: TextColors.inverse,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staff.name,
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    StaffDetailsGlassBadge(
                      label:
                          '${staff.role.name[0].toUpperCase()}${staff.role.name.substring(1)}',
                      color: PrimaryColors.defaultColor,
                    ),
                    const SizedBox(width: 8),
                    StaffDetailsGlassBadge(
                      label: staff.isActive ? 'Active' : 'Blocked',
                      color: staff.isActive
                          ? SemanticColors.success
                          : SemanticColors.error,
                      dot: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
