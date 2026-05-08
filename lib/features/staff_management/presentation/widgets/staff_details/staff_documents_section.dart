import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'components/empty_image_placeholder.dart';
import 'components/image_lightbox.dart';

/// Section showing the staff member's ID proof document.
class StaffDocumentsSection extends StatelessWidget {
  final StaffModel staff;

  const StaffDocumentsSection({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ID & DOCUMENTS',
            style: TextStyle(
              color: TextColors.secondary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          if (staff.idProof.isEmpty)
            const StaffDetailsEmptyImagePlaceholder(message: 'No ID proof uploaded')
          else
            GestureDetector(
              onTap: () => showStaffImageLightbox(context, staff.idProof, 'ID Proof'),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      staff.idProof,
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          height: 280,
                          color: NeutralColors.card,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: PrimaryColors.defaultColor,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, _, _) => const StaffDetailsEmptyImagePlaceholder(
                        message: 'Failed to load ID proof',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: NeutralColors.background.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.zoom_in, size: 14, color: TextColors.secondary),
                          SizedBox(width: 4),
                          Text(
                            'Tap to expand',
                            style: TextStyle(color: TextColors.secondary, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
