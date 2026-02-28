import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'components/glass_card.dart';
import 'components/glass_divider.dart';
import 'components/card_header.dart';
import 'components/empty_image_placeholder.dart';
import 'components/image_lightbox.dart';

class StaffDetailsIdProofCard extends StatelessWidget {
  final StaffModel staff;

  const StaffDetailsIdProofCard({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return StaffDetailsGlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StaffDetailsCardHeader(
            icon: Icons.badge_outlined,
            title: 'ID Proof Document',
          ),
          const StaffDetailsGlassDivider(),
          if (staff.idProof.isEmpty)
            const StaffDetailsEmptyImagePlaceholder(
              message: 'No ID proof uploaded',
            )
          else
            GestureDetector(
              onTap: () =>
                  showStaffImageLightbox(context, staff.idProof, 'ID Proof'),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    staff.idProof,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (ctx, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: NeutralColors.card,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: PrimaryColors.defaultColor,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, _, _) {
                      return const StaffDetailsEmptyImagePlaceholder(
                        message: 'Failed to load ID proof',
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
