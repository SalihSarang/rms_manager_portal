import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/id_proof_preview_dialog/components/staff_id_proof_preview_image.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class IdProofPreviewDialog extends StatelessWidget {
  final XFile? pickedIdProof;
  final String idProof;

  const IdProofPreviewDialog({
    super.key,
    this.pickedIdProof,
    this.idProof = '',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: NeutralColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ID Proof Preview',
                  style: TextStyle(
                    color: TextColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: TextColors.secondary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: StaffIdProofPreviewImage(
                  pickedIdProof: pickedIdProof,
                  idProof: idProof,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
