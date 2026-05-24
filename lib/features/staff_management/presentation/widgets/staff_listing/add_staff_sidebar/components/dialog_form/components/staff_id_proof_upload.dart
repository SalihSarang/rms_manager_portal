import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/id_proof_preview_dialog/id_proof_preview_dialog.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffIdProofUpload extends StatelessWidget {
  final XFile? pickedIdProof;
  final String idProof;

  const StaffIdProofUpload({
    super.key,
    required this.pickedIdProof,
    required this.idProof,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ID Proof',
          style: TextStyle(
            color: TextColors.secondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: NeutralColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: NeutralColors.border),
                ),
                child: Text(
                  pickedIdProof != null
                      ? pickedIdProof!.name
                      : idProof.isNotEmpty
                      ? 'ID Proof Uploaded'
                      : 'No file selected',
                  style: TextStyle(
                    color: idProof.isNotEmpty || pickedIdProof != null
                        ? TextColors.inverse
                        : TextColors.secondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 12),
            if (pickedIdProof != null || idProof.isNotEmpty) ...[
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => IdProofPreviewDialog(
                      pickedIdProof: pickedIdProof,
                      idProof: idProof,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: NeutralColors.background,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: NeutralColors.border),
                  ),
                ),
                icon: const Icon(Icons.visibility, size: 20),
                label: const Text('View'),
              ),
              const SizedBox(width: 12),
            ],
            ElevatedButton.icon(
              onPressed: () {
                context.read<AddStaffBloc>().add(IdProofChanged());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColors.defaultColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.upload_file, size: 20),
              label: const Text('Upload'),
            ),
          ],
        ),
      ],
    );
  }
}
